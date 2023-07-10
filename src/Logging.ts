import * as log4js from 'log4js';
import { inProductionMode } from './utils/Functions';

// This is the same logger as the one used by matrix-js-sdk
const log = log4js.getLogger('bridge.default');

for (const f of ['time', 'timeEnd']) {
    log[f] = {};
    for (const level of ['trace', 'debug', 'info', 'warn', 'error']) {
        log[f][level] = (label: string) => {
            if (log.level != log.level[level.toUpperCase()]) {
                console[f](label);
            }
        };
    }
}

interface LoggerTime {
    time: { [key: string]: (string) => void };
    timeEnd: { [key: string]: (string) => void };
}
export default log as log4js.Logger & LoggerTime;

export function getLogger(
    name: string,
    level: string = 'debug',
): log4js.Logger {
    const logger: log4js.Logger = log4js.getLogger(name);
    logger.level = inProductionMode() ? 'info' : level;
    return logger;
}
