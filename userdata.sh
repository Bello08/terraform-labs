

#!/bin/bash
apt update
apt install -y apache2
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to cloud computing  Learning</title>
    <style>
        body {
            background-color: #282c34;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        h1 {
            color: #61dafb;
            margin: 0.5em 0;
        }
        p {
            color: #adbac7;
            max-width: 600px;
            text-align: center;
            line-height: 1.6;
        }
        .container {
            text-shadow: 2px 2px 4px #000000;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }
        .vote-button {
            margin: 10px;
            padding: 10px 20px;
            font-size: 16px;
            color: #282c34;
            background-color: #61dafb;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        /* Removed hover effect to make the buttons static */
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome to Cloud computing AWS Series Tutorial</h1>
    <p>This is a beautifully colored HTML landing page for your AWS tutorial series. Enhanced with modern CSS styling for a more attractive and engaging user experience.</p>
    <p>This is the best AWS Tutorial series on the internet; Yes or No?</p>
    <form action="URL_TO_YOUR_BACKEND_ENDPOINT" method="post">
        <button type="submit" name="vote" value="yes" class="vote-button">Yes</button>
        <button type="submit" name="vote" value="no" class="vote-button">No</button>
    </form>
</div>

</body>
</html>
EOF
systemctl start apache2
systemctl enable apache2
