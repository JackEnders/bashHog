# bashHog
Use regular expressions based on [trufflehog](https://github.com/dxa4481/truffleHog) and OWASP's very underated [SEDATED](https://github.com/OWASP/SEDATED) project to identify secrets in an arbitrary directory, recursively.

Shout out to the SEDATED project for their great Regex testing file, which made life so much easier.

## Why This?
For people that find themselves in a situation where they want to find secrets they shouldn't have access to but:
- They only have a sh-compatible shell and GNU Grep (FreeBSD should also work, but is not what I test builds with)
- They want to search an arbitrary directory for secrets instead of a git repo
- They're willing to put up with less precise/more optimistic regex queries in the pursuit of greatness
- They're Lazy

## What are the Queries Actually Looking For?
### RSA private key
`\-\-\-\-\-BEGIN RSA PRIVATE KEY\-\-\-\-\-`

### SSH (OPENSSH) private key
`\-\-\-\-\-BEGIN OPENSSH PRIVATE KEY\-\-\-\-\-`

### SSH (DSA) private key
`\-\-\-\-\-BEGIN DSA PRIVATE KEY\-\-\-\-\-`

### SSH (EC) private key
`\-\-\-\-\-BEGIN EC PRIVATE KEY\-\-\-\-\-`

### PGP private key block
`\-\-\-\-\-BEGIN PGP PRIVATE KEY BLOCK\-\-\-\-\-`

### Facebook Oauth
`[f|F][a|A][c|C][e|E][b|B][o|O][o|O][k|K].{0,30}['\"\\s][0-9a-f]{32,45}['\"\\s]`

### Twitter Oauth
`[t|T][w|W][i|I][t|T][t|T][e|E][r|R].{0,30}['\"\\s][0-9a-zA-Z]{35,44}['\"\\s]`

### Github Oauth
`[g|G][i|I][t|T][h|H][u|U][b|B].{0,30}['\"\\s][0-9a-zA-Z]{35,40}['\"\\s]`

### Heroku Oauth
`[h|H][e|E][r|R][o|O][k|K][u|U].{0,30}[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}`

### Google Oauth
`(\"client_secret\":\"[a-zA-Z0-9_-]{0,24}\")`

### AWS API Key
`AKIA[0-9A-Z]{16}`

### Connection String
`[a-zA-Z]{3,10}://[^/\\s:@]{3,20}:[^/\\s:@]{3,20}@.{1,100}[\"'\\s]`

### "Secret"
`[s|S][e|E][c|C][r|R][e|E][t|T].{0,45}`

### "API Key"
`[a|A][p|P][i|I][_]?[-]?[k|K][e|E][y|Y].{0,45}`

### "Password"
`[p|P][a|A][s|S][s|S][w|W][o|O][r|R][d|D].{0,45}`

### "Sensitive"
`[s|S][e|E][n|N][s|S][i|I][t|T][i|I][v|V][e|E].{0,45}`

### Slack Webhook
`https://hooks.slack.com/services/T[a-zA-Z0-9_]{8}/B[a-zA-Z0-9_]{8}/[a-zA-Z0-9_]{24}`

### Twilio API Key
`SK[a-z0-9]{32}`

## Pull Requests?
Please! If you hadd a new query to rules.txt, please add a corresponding entry to readme.md and test_rules.txt describing what you're trying to detect
