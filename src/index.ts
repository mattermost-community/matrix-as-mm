#! /usr/bin/env node
import * as log4js from 'log4js';
import yargs from 'yargs';

import { writeFileSync } from 'fs';
import * as yaml from 'js-yaml';

import { loadYaml, randomString } from './utils/Functions';
import { validate } from './Config';
import { Registration } from './Interfaces';

import Main from './Main';
import log, { getLogger } from './Logging';

console.time('Bridge loaded');
const TRACE_ENV_NAME = 'API_TRACE';

//let argv = undefined
const parser = yargs(process.argv.slice(2))
    .options({
        f: {
            describe: 'registration file',
            nargs: 1,
            demand: true,
            type: 'string',
            default: 'registration.yaml',
        },
        c: {
            describe: 'configuration file',
            nargs: 1,
            demand: false,
            type: 'string',
            default: 'config.yaml',
        },
        r: { describe: 'generate registration file', type: 'boolean' },
        s: {
            describe: 'Setup/Sync database connection to configuration db',
            type: 'boolean',
        },
        a: { describe: 'extended tracing of API calls', type: 'boolean' },
        p: { describe: 'production mode. Minimal logging', type: 'boolean' },
        l: {
            describe: 'log directory',
            nargs: 1,
            demand: false,
            type: 'string',
        },
    })
    .scriptName('mm-matrix-connector')
    .help('help')
    .alias('h', 'help');

(async () => {
    const argv = await parser.argv;
    if (argv.s) {
        console.info('Setup database connection to configuration database...');
        const main = new Main(loadYaml(argv.c), argv.f, true);
        void main.setupConfigDatabase();
    } else if (argv.r === undefined) {
        if (argv.p) {
            process.env.NODE_ENV = 'production';
        }
        const myLogger: log4js.Logger = getLogger('index.js');
        const apiTraceEnv = process.env[TRACE_ENV_NAME];
        const traceApi: boolean =
            argv.a ||
            (apiTraceEnv && apiTraceEnv.toLocaleLowerCase() === 'true'
                ? true
                : false);
        if (traceApi) {
            process.env[TRACE_ENV_NAME] = 'true';
            myLogger.info('Extend API trace=%s', process.env[TRACE_ENV_NAME]);
        }
        const logDir = argv.l;

        const main = new Main(loadYaml(argv.c), argv.f, true, traceApi, logDir);

        log.timeEnd.info('Bridge loaded');
        await main.init();
        process.on('SIGTERM', () => {
            myLogger.info('Received SIGTERM. Shutting down bridge.');
            void main.killBridge(0);
        });
        process.on('SIGINT', () => {
            myLogger.info('Received SIGINT. Shutting down bridge.');
            void main.killBridge(0);
        });
        process.on('SIGHUP', () => {
            myLogger.info('Received SIGHUP. Reloading config.');

            const newConfig = loadYaml(argv.c);
            try {
                validate(newConfig);
            } catch (e) {
                myLogger.error(`Invalid config: ${e}`);
            }
            main.updateConfig(newConfig).catch(e => {
                myLogger.error(e);
            });
        });
    } else {
        const config = loadYaml(argv.c);
        validate(config);

        const registration: Registration = {
            id: randomString(64),
            hs_token: randomString(64),
            as_token: randomString(64),
            namespaces: {
                users: [
                    {
                        exclusive: true,
                        regex: `@${config.matrix_localpart_prefix}.*:${config.homeserver.server_name}`,
                    },
                ]
            },
            url: `${config.appservice.schema}://${config.appservice.hostname}:${config.appservice.port}`,
            sender_localpart: config.matrix_bot.username,
            rate_limited: true,
            protocols: ['mattermost'],
        };

        writeFileSync(argv.f, yaml.dump(registration));

        console.info(`Output registration to: ${argv.f}`);
        process.exit(0);
    }
})();
