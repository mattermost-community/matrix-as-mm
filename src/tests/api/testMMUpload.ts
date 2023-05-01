import * as mmClient from '../../mattermost/Client'
import * as conf from '../../Config'
import * as log4js from 'log4js';
import * as fs from 'fs'
import * as path from 'path';
import * as util from 'util';
import { loadYaml} from '../../utils/Functions';

function saveFile(file,dir, content: Buffer) {
    const fileName = path.resolve(dir, file)
    try {
        fs.writeFileSync(fileName, content)
        logger.info("Saving file for debugging %s", fileName)
    }
    catch (error) {
        logger.error("Failed to save file  %s", fileName)
    }
}


let logger=log4js.getLogger('testMMUpload')
logger.level='debug'
let configYaml=loadYaml('config.yaml')
conf.validate(configYaml)
conf.setConfig(configYaml,true)
const config:conf.Config=conf.config()
const client:mmClient.Client = new mmClient.Client(
    config.mattermost_url,
    config.mattermost_bot_userid,
    config.mattermost_bot_access_token
)

async function run() {
    let resultDir = process.argv[2] 
    if (!fs.existsSync(resultDir) || !fs.lstatSync(resultDir).isDirectory()){
        logger.error("Result dir %s is not valid", resultDir)
        return false
    }

    
    try {

        for (let i = 3; i < process.argv.length; i++) {
            let fileId: string = process.argv[i]
            let fileInfo=await client.get(`/files/${fileId}/info`)
            console.info(fileInfo.name)
            let content:Buffer=await client.getFile(fileId)
            saveFile(fileInfo.name,resultDir,content)
        }
    }
    catch (err) {
        logger.error("error: ",err.message)

    }
}

run()



