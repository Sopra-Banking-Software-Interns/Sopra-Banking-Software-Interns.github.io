#!/bin/bash

code='<!doctype html>
<html lang="en">
  <head>
  	<title>Github Leaderboard - Dashboard</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Roboto:400,100,300,700" rel="stylesheet" type="text/css">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<link rel="stylesheet" href="table-05/css/style.css">

	</head>
	<body>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Github Leader - Dashboard</h2>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="table-wrap">
						<table class="table table-responsive-xl">
						  <thead>
						    <tr>
						    	<th>&nbsp;</th>
						    	<th>Avatar</th>
						      <th>Username</th>
						      <th>Contributions</th>
						      <th>&nbsp;</th>
						    </tr>
						  </thead>
                          <tbody>'

echo "$code" > overwrite.html   
echo "Code copied to overwrite.html successfully!"

#!/bin/bash

json_file="contribution_final.json"

html_code='
<tr class="alert" role="alert">
	<td>
		<label class="checkbox-wrap checkbox-primary">
			<input type="checkbox" checked>
			<span class="checkmark"></span>
		</label>
	</td>
	<td class="d-flex align-items-center">
		<div class="img" style="background-image: url(url_placeholder);"></div>
		<div class="pl-3 email">
			<span>markotto@email.com</span>
		</div>
	</td>
	<td>Markotto89</td>
	<td class="status"><span class="active">Active</span></td>
	<td>
		<button type="button" class="close" data-dismiss="alert" aria-label="Close">
			<span aria-hidden="true"><i class="fa fa-close"></i></span>
		</button>
	</td>
</tr>
'

# Read JSON file and loop through data objects
json=$(cat contribution_final.json)

# Loop through each object in the JSON array
for obj in $(echo "${json}" | jq -c '.[]'); do
  # Extract user and score values
  user=$(echo "${obj}" | jq -r '.user')
  score=$(echo "${obj}" | jq -r '.score')

  image_url=$(curl -s -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $token"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/users/$user | jq -r '.avatar_url')
  # Echo user and score
	modified_code="${html_code/url_placeholder/$image_url}"
    modified_code="${modified_code/markotto@email.com/$user}"
    modified_code="${modified_code/Markotto89/$user}"
    modified_code="${modified_code/Active/$score}"
	echo "$modified_code" >>temp.html
done

# Append the modified HTML code to index.html
cat temp.html >>overwrite.html
rm temp.html

echo "HTML code appended to index.html successfully!"

Post_code='</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script src="table-05/js/jquery.min.js"></script>
  <script src="table-05/js/popper.js"></script>
  <script src="table-05/js/bootstrap.min.js"></script>
  <script src="table-05/js/main.js"></script>

	</body>
</html>
'

echo "$Post_code" > temp.html
cat temp.html >> overwrite.html
rm temp.html   
echo "Code copied to overwrite.html successfully!"

cat overwrite.html > index.html
rm overwrite.html
