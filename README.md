# GitLab periodic build trigger Docker image

This repo contains a base image to set up a periodic build trigger for GitLab. To create your own periodic build trigeer simply use the image as base and add the cron tab.

The container contains a script to easily a build on GitLab:
```
trigger-gitlab.sh -t <token> -r <ref> -u <url>
```

For more details on build triggers see the GitLab [documentation](https://docs.gitlab.com/ce/ci/triggers/)

## Setup your own periodic build
### Dockerfile
```
FROM npalm/gitlab-periodic-trigger
```

### Add a crontab
Add a file in the root named gitlabcrontab which contains crontab entries as follow:
```
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7)
# |  |  |  |  |
# *  *  *  *  *   command to be executed
0 * * * * trigger-gitlab.sh -t <token> -r <ref> -u <gitlab_trigger_url>
```

### build
```
docker build -t gitlab-triggers .
```

### Run
```
docker run -d --restart=always gitlab-trigger
