# ERC-ME

Version 1.0  Last edited on: 10/01/2017

Ghilia Weldesselasie -- <a href='mailto:ghiliaweld@gmail.com'>ghiliaweld@gmail.com</a></br>

---

## Summary
ERC-721 token that represents you and your identity. ERC-ME is a digital badge or a personal cryptocurrency/token that represents you and can be used in various Dapps or other contracts on the blockchain.

Simpler alternative to Civic and the like because your identity is tied to a token instead of an address. A token is a lot easier to transfer. You can easily transfer your profile to a new address in case your wallet were to be compromised or you just feel like using a new wallet. Is this a problem that needs solving? I don't know yet.

This could also potentially be very expensive since you would need to pay gas every time you want to make any state changes to your token on the blockchain. However, this problem could also be mitigated by something I call deferred updating where updating the *Profile* struct is deferred until a larger update can be made in one shot. For example, instead of updating your following count every time you get a new follower and paying a gas fee for that, you could decide that every 10 new followings your following count should be updated. that way you only pay 1 gas fee but you can add 10 more profiles to your following count.

Not my best idea to date, especially considering the gas problem, but it has the potential to be interesting depending on how it's used. Apps and games could stop hosting user data and instead host experiences for users, where the user's data belongs to them and can be exported to another platform at any time.

What I'm going for can be summed up in three words: **Experiences, not services**.

## Vision / Use Cases
- You profile/identity could be exported to different social networks where your ERC-ME token can represent your profile (with name, handle, follower/following count). Instead of storing user info, social networks could simply concern themselves with the UX. user info would be hosted on the blockchain instead of being hosted off chain.
- Your profile can also be brought to different games as well. If the game studio wants, you progress in other games could also determine your current level in this game (meaning you could potential start the game at a high level). Current rank could also be based on current follower count or follower-to-following ratio.
