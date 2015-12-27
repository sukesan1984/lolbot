child_process = require 'child_process'
module.exports = (robot) ->
    robot.hear /[チ|ち]ー[ム|む][分|わ]けして (.*)/i, (msg) ->
        names = msg.match[1].split(",")
        data = JSON.stringify({
            token: 'zX2CaMHmxjFHzxgzggmKwSxLpZnP9_qd',
            email: 'loljp@loljp.com',
            names: names.join(",")
        })
        if (names.length < 10)
            msg.send "10人以上選んでね"
            return
        if (names.length > 14)
            msg.send "３チーム以上できちゃうね。"
            return

        msg.http('http://pentakill.org/players/classify_api.json')
            .header('Content-Type', 'application/json')
            .post(data) (err, res, body) ->
                response = JSON.parse body
                team_a = response["teams"][0]["map"]
                team_a_tier = response["teams"][0]["total_tier"]
                team_b = response["teams"][1]["map"]
                team_b_tier = response["teams"][1]["total_tier"]
                no_hits = response["no_hits"]
                rest = response["rest"]

                team_a_member = []
                team_b_member = []
                rest_member = []

                for k,v of team_a
                    team_a_member.push(v.name)

                for k,v of team_b
                    team_b_member.push(v.name)

                for k,v of rest
                    rest_member.push(v.name)

                msg.send """
                    ```
                    チーム(左): #{team_a_tier}
                    #{team_a_member.join(",")}
                    チーム(右): #{team_b_tier}
                    #{team_b_member.join(",")}
                    君たちはデータ登録がなかったから、unranked(0)で計算したよ
                    #{no_hits.join(",")}
                    君たちは今回は休憩だよ
                    #{rest_member.join(",")}
                    ```
                """
    #robot.respond /.*$/i, (msg) ->
        #summonername = msg.message.text.replace(/lolbot: /, "")
        #console.log(summonername)
        #child_process.exec "ruby /app/scripts/search_single.rb #{summonername} \/T", (error, stdout, stderr) ->
            #console.log("respond" + summonername)
            #if !error
                #console.log("success")
                #output = stdout + ''
                #console.log(output)
                #if(!output)
                    #msg.send "今は#{summonername}はやってないよ"
                #else
                    #msg.send output
            #else
                #console.log("error")
                #msg.send "error"
                #console.log error
                #console.log stderr

    #robot.respond /all .*$/i, (msg) ->
        #summonername = msg.message.text.replace(/lolbot: all /, "")
        #child_process.exec "ruby /app/scripts/test.rb #{summonername} \/T", (error, stdout, stderr) ->
            #console.log("respond" + summonername)
            #if !error
                #console.log("success")
                #output = stdout + ''
                #console.log(output)
                #if(!output)
                    #msg.send "今は#{summonername}はやってないよ"
                #else
                    #msg.send output
            #else
                #console.log("error")
                #msg.send "error"
                #console.log error
                #console.log stderr
