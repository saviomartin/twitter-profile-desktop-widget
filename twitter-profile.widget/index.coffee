#-----------------------------------------------------------------------#
# Twitter Profile Widget by Savio Martin
# https://twitter.com/saviomaritn7

# ✨ Your twitter account username
twitter_account = "saviomartin7"

# 🎨 themes (Dark and Light) to match your wallpaper
theme = "Light"

# 🧭 Widget position on the screen
position = "top-right"

# 🔄 Refreshes 10 minutes (written in milliseconds)
refreshFrequency: 600000
#-----------------------------------------------------------------------#

if theme == "Light"
  mainColor = "#fff"
  accentColor = "#bbb"
  twitterBlueColor = "#1DA1F2"
else
  mainColor = "#444"
  accentColor = "#888"
  twitterBlueColor = "#1DA1F2"

if position == "top-left"
  top = "2.5em"
  left = "2.5em"
else if position == "top-right"
  top = "2.5em"
  right = "2.5em"
else if position == "bottom-left"
  bottom = "2.5em"
  left = "2.5em"
else if position == "bottom-right"
  bottom = "2.5em"
  right = "2.5em"

command: "curl -H \"Content-Type: application/json\" \"https://cdn.syndication.twimg.com/widgets/followbutton/info.json?screen_names=#{twitter_account}\" 2>/dev/null"

style: """
  top: #{top}
  right: #{right}
  left: #{left}
  bottom: #{bottom}
  font-family: 'system-ui'
  color: #{mainColor}

  .container {
    display: flex
    align-items: center
    justify-content: center
  }
  .profilePicture {
    border-radius: 1em
    box-shadow: 0px 0px 30px #{twitterBlueColor}70
    height: 70px
    width: 70px
    margin-right: 20px
  }
  h1 {
    font-weight: 700
    font-size: 2.3em
    line-height: 0.1em
  }
  h4 {
    color: #{accentColor}
    line-height: 0.1em
    margin-top: 10px
    font-weight: 600
    font-size: 14px
  }
  .twitter_username {
    color: #{twitterBlueColor}
  }
  .followers_label {
    color: #888
    margin-left: 6px
    margin-right: 6px
  }
  .salutation {
    display: flex
  }
  .profile {
    position: relative
  }
  .twitter_icon {
    position: absolute
    height: 25px
    width: 25px
    bottom: 0
    right: 10px
    transition: 0.5s
  }
  .profile:hover .twitter_icon {
    transform: scale(1.175)
  }
"""

render: -> """
  <div class="container">
    <div class="profile">
      <img class="profilePicture" src="https://unavatar.io/twitter/#{twitter_account}" />
      <img class="twitter_icon" src="twitter-profile.widget/twitter_logo.svg" />
    </div>
    <div class="data">
      <h1 class='followers_count'></h1>
      <div class="salutation">
        <h4>Followers</h4>
        <h4 class="followers_label">•</h4>
        <h4 class="twitter_username hover-underline-animation" target="_blank">@#{twitter_account}</h4>
        </div>
    </div>
  </div>
"""

update: (output,domEl) ->
  output = output.replace(/["']/g, "")
  values		= output.split(",")
  followersCount 		= values[5].split(":")[1].split(" ")[0]
  div			= $(domEl)

  div.find('.followers_count').text(Number(followersCount).toLocaleString('en-US'))
