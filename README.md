# Shell Scripting with AWS EC2, Bash & Git

A system-monitoring project built on an AWS EC2 Ubuntu instance using
Bash scripting, cron automation, and Git/GitHub for version control.

## Project Description

This project uses a Bash script named `monitoring.sh` to collect basic
system information from an Ubuntu EC2 instance. It displays running
services, CPU activity, memory usage, and disk usage. The output can be
appended to `monitor_logs.txt`, and a cron job runs the script
automatically every day at **12:00 AM (midnight)**.

## Technologies Used

-   AWS EC2
-   Ubuntu Linux
-   Bash Shell Scripting
-   Cron
-   Git and GitHub
-   SSH / MobaXterm

## Features

-   Lists running system services
-   Displays CPU and process activity
-   Reports memory and swap usage
-   Reports filesystem disk usage
-   Saves monitoring output to a log file
-   Automates daily execution with cron
-   Tracks project changes with Git and GitHub

## Project Structure

``` text
shell-assignment/
├── monitoring.sh
├── monitor_logs.txt
└── README.md
```

`monitor_logs.txt` is created when output is redirected to it. It may
not exist until the first logging run.

## Implementation Steps

### Day 1: Environment Setup and Monitoring Script

#### 1. Launch an AWS EC2 Instance

1.  Sign in to the [AWS Management
    Console](https://console.aws.amazon.com/).

2.  Open **EC2** and select **Launch instance**.

3.  Choose an Ubuntu Server image.

4.  Select an instance type and check its current Free Tier eligibility.

5.  Create or select a key pair.

6.  Configure the security group to allow SSH (TCP port 22) from your
    trusted IP address.

7.  Launch the instance and connect using MobaXterm or a terminal:

    ``` bash
    ssh -i key.pem ubuntu@EC2_PUBLIC_IP
    ```

    Replace `key.pem` and `EC2_PUBLIC_IP` with your own key file and
    instance public IP.

#### 2. Install Git

``` bash
sudo apt update
sudo apt install git -y
git --version
```

#### 3. Create the Project Directory and Initialize Git

``` bash
mkdir shell-assignment
cd shell-assignment
git init
```

If the directory already exists, use `cd ~/shell-assignment` rather than
creating it again.

#### 4. Create `monitoring.sh`

Create or edit the script:

``` bash
vim monitoring.sh
```

The script contains these monitoring commands:

``` bash
#!/bin/bash

# Display running services
sudo systemctl list-units --type=service --state=running --no-pager

# Display CPU activity
top -b -n 1

# Display memory usage
free -h

# Display disk usage
df -h
```

The actual script also includes headings to separate the sections and
uses `set -e` to stop if a command fails.

Make the script executable and run it:

``` bash
chmod +x monitoring.sh
./monitoring.sh
```

#### 5. Push the Project to GitHub

Create a repository on GitHub. If you already have a local project,
creating an **empty** remote repository (without an initial README or
license) avoids unrelated initial histories.

From the project directory, stage and commit your files:

``` bash
git add .
git commit -m "Monitoring Script Commit"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

Replace `YOUR_GITHUB_REPOSITORY_URL` with your repository URL. If
`origin` is already configured, do not add it again; check it with:

``` bash
git remote -v
```

### Day 2: Logging and Automation

#### 6. Save Monitoring Output to a Log File

Run the script and append its output to `monitor_logs.txt`:

``` bash
./monitoring.sh >> monitor_logs.txt 2>&1
```

-   `>>` appends output without replacing existing log contents.
-   `2>&1` sends error output to the same log file.

View the log:

``` bash
cat monitor_logs.txt
```

#### 7. Improve the Monitoring Output

The script uses headings and separator lines to make the output easier
to read. You can add a timestamp or a completion message to each run if
desired.

#### 8. Schedule Automation Using Cron

Open the current user's crontab:

``` bash
crontab -e
```

Add this entry to run the script **every day at 12:00 AM (midnight)**
and append output to the log:

``` cron
0 0 * * * /home/ubuntu/shell-assignment/monitoring.sh >> /home/ubuntu/shell-assignment/monitor_logs.txt 
```

Make sure the script is actually located at
`/home/ubuntu/shell-assignment/monitoring.sh`. If it is elsewhere,
update the paths in the cron entry.

Verify the schedule:

``` bash
crontab -l
```

**Cron timing:** `0 0 * * *` means minute 0, hour 0, every day of the
month, every month, and every day of the week. Cron uses the system's
configured timezone, so check the EC2 instance timezone if midnight must
correspond to a particular local time.

**Cron and `sudo`:** The script runs `sudo systemctl ...`. Cron is
non-interactive, so this command may fail if it requires a password.
Test the script under the same user and configure permissions carefully
if needed. Do not put a password in the script.

#### 9. Commit and Push Updates

``` bash
git add .
git commit -m "Update monitoring documentation and logging"
git push origin main
```

If the push is rejected because the remote contains commits that are
missing locally, integrate the remote changes first, resolve any
conflicts, and then push.

## Result

Implemented a basic system-monitoring solution on AWS EC2 using Bash.
The script reports running services, CPU activity, memory usage, and
disk usage. Its output is appended to a log file, and cron is configured
to run it daily at midnight. Git and GitHub provide version control.

## Skills Demonstrated

-   Linux command-line administration
-   Bash scripting
-   System resource monitoring
-   Log file management
-   Cron job scheduling
-   AWS EC2 setup and SSH access
-   Git version control and GitHub

