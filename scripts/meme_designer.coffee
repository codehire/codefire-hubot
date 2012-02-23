# Generates images with memegenerator.net
#
# meme [me] <meme> [<top>|]<bottom> - Generates an image for <meme> with top text <top> and bottom text <bottom>.
# memes - Shows a list of meme keywords that you can use.

module.exports = (robot) ->
  memes =
    yuno:
      generator: 2
      image: 166088
    philosoraptor:
      generator: 17
      image: 984
    bachelorfrog:
      generator: 3
      image: 203
    insanitywolf:
      generator: 45
      image: 20
    sociallyawkwardpenguin:
      generator: 29
      image: 983
    ducreux:
      generator: 54
      image: 42
    couragewolf:
      generator: 303
      image: 24
    foreveralone:
      generator: 116
      image: 142442
    fry:
      generator: 305
      image: 84688
    successkid:
      generator: 121
      image: 1031
    trollface:
      generator: 68
      image: 269
    interestingman:
      generator: 74
      image: 2485
    goodguygreg:
      generator: 534
      image: 699717
    yodawg:
      generator: 79
      image: 108785
    orly:
      generator: 920
      image: 117049
    allthethings:
      generator: 6013
      image: 1121885
    toodamnhigh:
      generator: 998
      image: 203665
    farnsworth:
      generator: 1591
      image: 112464
    annoyingfacebookgirl:
      generator: 839
      image: 876097
    businesscat:
      generator: 308
      image: 332591
    pissedoffobama:
      generator: 9470
      image: 45557
    scumbagsteve:
      generator: 142
      image: 366130

  robot.respond /(list )?memes?$/i, (msg) ->
    names = []
    for k,v of memes
      names.push k
    msg.send "These are the memes you can use: #{names.join(", ")}."

  robot.respond /meme(?:\s+me)?\s+(\S+)(\s+[^|]+)?(?:\s*\|\s*(.*))?/i, (msg) ->
    memeName = msg.match[1].toLowerCase()
    topText = if msg.match[2]? then msg.match[2].trim() else ''
    bottomText = if msg.match[3]? then msg.match[3].trim() else ''
    meme = memes[memeName]
    if meme?
      memeGenerator msg, meme.generator, meme.image, topText, bottomText, (url) ->
        msg.send url
    else
      msg.reply "I don't know that meme."


memeGenerator = (msg, generatorID, imageID, text0, text1, callback) ->
  username = process.env.HUBOT_MEMEGEN_USERNAME
  password = process.env.HUBOT_MEMEGEN_PASSWORD
  preferredDimensions = process.env.HUBOT_MEMEGEN_DIMENSIONS

  unless username? and password?
    msg.send "MemeGenerator account isn't setup. Sign up at http://memegenerator.net"
    msg.send "Then ensure the HUBOT_MEMEGEN_USERNAME and HUBOT_MEMEGEN_PASSWORD environment variables are set"
    return

  msg.http('http://version1.api.memegenerator.net/Instance_Create')
    .query
      username: username,
      password: password,
      languageCode: 'en',
      generatorID: generatorID,
      imageID: imageID,
      text0: text0,
      text1: text1
    .get() (err, res, body) ->
      result = JSON.parse(body)['result']
      if result? and result['instanceUrl']? and result['instanceImageUrl']? and result['instanceID']?
        instanceID = result['instanceID']
        instanceURL = result['instanceUrl']
        img = result['instanceImageUrl']
        msg.http(instanceURL).get() (err, res, body) ->
          # Need to hit instanceURL so that image gets generated
          if preferredDimensions?
            callback "http://images.memegenerator.net/instances/#{preferredDimensions}/#{instanceID}.jpg"
          else
            callback "http://images.memegenerator.net/instances/#{instanceID}.jpg"
      else
        msg.reply "Sorry, I couldn't generate that image."
