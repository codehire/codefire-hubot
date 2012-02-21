# Responses for Codefire

module.exports = (robot) ->

  # Functions to use later.

  respond_to_shut_up = (msg) ->
    responses = [
      "No.",
      "Um, no.",
      "How about no?",
      "Don't think so, mate.",
      "Not gonna happen."
    ]
    msg.reply msg.random responses

  respond_to_thanks = (msg) ->
    responses = [
      "Too easy.",
      "Too easy, mate.",
      "No worries.",
      "No worries, mate.",
      "Good on ya.",
      "Good on ya, mate."
    ]
    msg.reply msg.random responses

  respond_to_hello = (msg) ->
    msg.reply msg.random ["Hello!", "G'day!", "Hi!"]

  respond_to_goodbye = (msg) ->
    msg.reply msg.random ["Bye.", "Later.", "See ya.", "See you later."]

  respond_to_love = (msg) ->
    msg.reply msg.random ["I know.", "Right back at ya, mate.", "That's super.", "<3", "Love you too, mate."]

  respond_to_apology = (msg) ->
    msg.reply msg.random ["No problem.", "That's okay.", "No biggie.", "Think nothing of it."]

  respond_to_insult = (msg) ->
    msg.reply msg.random ["Excuse me?", "...", "Wow, you're a clever one.", "Robots have feelings too, you know.", "Same to you, pal.", "WOW, BIG MAN"]

  # Conversational stuff.

  shut_up = /(shut up|shut the (\w+) up|shut it|be quiet|quiet|stfu|shutup)/i
  robot.respond shut_up, respond_to_shut_up
  robot.hear new RegExp("\\s*" + shut_up.source + ",? hubot\\.*\\s*$", "i"), respond_to_shut_up

  thanks = /(thanks|thank you|cheers|nice one|ta|ty|thx|good job|nice job|great job|you rock)/i
  robot.respond new RegExp(thanks.source + "\\s*$", "i"), respond_to_thanks
  robot.hear new RegExp("\\s*" + thanks.source + "( for .+)?,? hubot\\.*\\s*$", "i"), respond_to_thanks

  hello = /(hi|hello|gday|g'day|what's up|whats up|what up|sup|hey|hiya|heya|yo|mornin|mornin'|morning|good morning|afternoon|good afternoon|wotcher)/i
  robot.respond new RegExp(hello.source + "\\s*$", "i"), respond_to_hello
  robot.hear new RegExp("\\s*" + hello.source + ",? hubot\\.*\\s*$", "i"), respond_to_hello

  goodbye = /(bye|goodbye|good-bye|bye-bye|see you|see you later|see ya|cya|later|evening|good evening|night|good night|goodnight|have a good one)/i
  robot.respond new RegExp(goodbye.source + "\\s*$", "i"), respond_to_goodbye
  robot.hear new RegExp("\\s*" + goodbye.source + ",? hubot\\.*\\s*$", "i"), respond_to_goodbye

  love = /(i( \S+)? love you)/i
  robot.respond new RegExp(love.source + "\\s*$", "i"), respond_to_love
  robot.hear new RegExp("\\s*" + love.source + ",? hubot\\.*\\s*$", "i"), respond_to_love

  apology = /(sorry|I'm sorry)/i
  robot.respond new RegExp(apology.source + "\\s*$", "i"), respond_to_apology
  robot.hear new RegExp("\\s*" + apology.source + ",? hubot\\.*\\s*$", "i"), respond_to_apology

  insult = /(fuck you|screw you|damn you|fuck off)/i
  robot.respond new RegExp(insult.source + "\\s*$", "i"), respond_to_insult
  robot.hear new RegExp("\\s*" + insult.source + ",? hubot\\.*\\s*$", "i"), respond_to_insult

  # Build messages.
  
  robot.hear /^'Build successful for "([a-zA-Z0-9_-]+)/, (msg) ->
    if msg.message.user.name == "Bamboo CI"
      msg.send msg.random ["YES", "WOOT", "WINNING", "WIN", "Awesome.", "Excellent.", "Nice."]
 
  robot.hear /^'Build failed for "([a-zA-Z0-9_-]+)/, (msg) ->
    if msg.message.user.name == "Bamboo CI"
      msg.send msg.random ["NOOOOOO!", "LOL FAIL", "Uh oh.", "That's not good.", "That's a problem.", "Who broke the build?"]

  # Hubot helps you decide where to eat.

  robot.respond /where should (?:i|we) eat(?:\s+lunch)?\s*\??\s*$/i, (msg) ->
    msg.reply "Where should you eat... in which city?"

  robot.respond /where should (?:i|we) (?:eat|have)(?:\s+lunch)? in (.*?)\s*\??\s*$/i, (msg) ->
    city = msg.match[1]
    switch city.toLowerCase()
      when "launceston"
        eateries = ["Ellie May's", "Wan", "Mojo", "Koreana BBQ", "Banjo's", "Ali's Asian Cafe", "Bubbalicious", "Yolanda Jean Cafe (warning: slow!)", "Delicious", "Subway", "instant noodles at your desk"]
        msg.reply "I suggest #{msg.random eateries}."
      when "adelaide"
        msg.reply "Sorry, I don't know any places in Adelaide."
      else
        msg.reply "I don't know that city."

  robot.hear /^ls$/, (msg) ->
    msg.send "Applications/  Downloads/     Movies/        Public/\n
Desktop/       Dropbox/       Music/         Sites/\n
Documents/     Library/       Pictures/      manifesto.txt"

  SPELLING_IMAGES = ['http://c4262601.r1.cf2.rackcdn.com/spelling_1.jpg', 
                     'http://c4262601.r1.cf2.rackcdn.com/spelling_2.jpg',
                     'http://c4262601.r1.cf2.rackcdn.com/spelling_3.jpg',
                     'http://c4262601.r1.cf2.rackcdn.com/spelling_4.jpg',
                     'http://c4262601.r1.cf2.rackcdn.com/spelling_5.jpg']

  respond_to_spelling = (msg) ->
    msg.send msg.random SPELLING_IMAGES

  robot.respond /spelling[?.!]*\s*$/i, respond_to_spelling
  robot.hear /^\s*spelling[?.!]*\s*$/i, respond_to_spelling

  respond_to_grammar = (msg) ->
    msg.send "http://c4262601.r1.cf2.rackcdn.com/grammer.jpg"

  robot.respond /gramm[ae]r[?.!]*\s*$/i, respond_to_grammar
  robot.hear /^\s*gramm[ae]r[?.!]*\s*$/i, respond_to_grammar

  robot.hear /^\s*(landed|land(ed)? +it)\s*[?.!]*\s*$/i, (msg) ->
    msg.send "http://catholicpilot.com/wp-content/uploads/2010/07/Frenchcrosswindtechnique.jpg"

  robot.hear /^\s*(i +)?disapprov(e|al)\s*[?.!]*\s*$/i, (msg) ->
    msg.send "http://www.themarysue.com/wp-content/uploads/2011/11/look-of-disapproval-lisa-300x288.jpg"

  robot.hear /^\s*(i +)?approv(e|al)\s*[?.!]*\s*$/i, (msg) ->
    msg.send "http://3.bp.blogspot.com/_T1FQu5_6WZs/TDE-7UiGk0I/AAAAAAAAAKM/X_-2kM7ZdXM/s1600/chuck_norris_approved.jpg"

  robot.hear /^\s*cruis(?:e|ing|in'|in)\s*[?.!]*\s*$/i, (msg) ->
    msg.send "http://media1.onsugar.com/files/2011/05/21/4/301/3019466/f56f5cf65e876972_tom-cruise.larger/i/Oprah-Meltdowns.jpg"
