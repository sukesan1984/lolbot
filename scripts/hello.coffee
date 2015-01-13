child_process = require 'child_process'
module.exports = (robot) ->
    robot.respond /.*$/i, (msg) ->
        summonername = msg.message.text.replace(/lolbot: /, "")
        console.log(summonername)
        child_process.exec "ruby /app/scripts/search_single.rb #{summonername} \/T", (error, stdout, stderr) ->
            console.log("respond" + summonername)
            if !error
                console.log("success")
                output = stdout + ''
                console.log(output)
                if(!output)
                    msg.send "今は#{summonername}はやってないよ"
                else
                    msg.send output
            else
                console.log("error")
                msg.send "error"
                console.log error
                console.log stderr

    robot.respond /all .*$/i, (msg) ->
        summonername = msg.message.text.replace(/lolbot: all /, "")
        child_process.exec "ruby /app/scripts/test.rb #{summonername} \/T", (error, stdout, stderr) ->
            console.log("respond" + summonername)
            if !error
                console.log("success")
                output = stdout + ''
                console.log(output)
                if(!output)
                    msg.send "今は#{summonername}はやってないよ"
                else
                    msg.send output
            else
                console.log("error")
                msg.send "error"
                console.log error
                console.log stderr
