import tweepy

consumer_key = "45ho6BOOnTd7E5Psptlns9CU2";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "8JeTtZAmjXmC6kdBm13bIBlMig51xhDV7ciRZ961zc52BD0Q9V";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "843619900023226368-6nYCTJwnQSjospaZgZutk7A17JxmpPt";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "zkmMJGaFxDenRQOsX5pwmfaomjz5CgPupY7fX1sCmWlU2";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



