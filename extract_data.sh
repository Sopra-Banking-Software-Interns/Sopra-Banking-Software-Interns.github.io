#GET the contributors list from GIT Hub
REPO="Sopra-Banking-Software-Interns/Github-Learderboard""
curl -s -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $token"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/Sopra-Banking-Software-Interns/unified-automation-suite/contributors | jq -r '.[] | {login, contributions}' >> contributions.txt

#POST the contributors list to the leaderboard
jq -s '.' contributions.txt >> contributions.json
rm contributions.txt

sed 's/login/user/g; s/contributions/score/g' contributions.json > contribution_final.json
rm contributions.json

# Create a database for the leaderboard
# Read the JSON file into a variable
json=$(cat contribution_final.json)
OWNER="Sopra-Banking-Software-Interns"
REPO="unified-automation-suite"

# Make a request to fetch closed issues of a contributor
response=$(curl -s -L \
   -H "Accept: application/vnd.github+json" \
   -H "Authorization: Bearer $token" \
   -H "X-GitHub-Api-Version: 2022-11-28" \
     "https://api.github.com/repos/$OWNER/$REPO/issues?state=closed")