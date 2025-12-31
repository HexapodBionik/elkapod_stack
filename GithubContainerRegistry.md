# Working with GithubContainerRegistry (ghcr.io)
## Token generation
In the first step you have to login to github container registry using `docker login` command. To do so you have to generate a classic github token to be able to login to your account. See instructions about generating classic tokens: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

Then save the token to some file, eg. `github_docker_token.txt` and use it for authentication:
```bash
cat github_docker_token.txt | docker login ghcr.io -u <YOUR_NAME> --password-stdin
```

## Building && pushing
```bash
docker build --network=host -t ghcr.io/hexapodbionik/elkapod_sim:latest .
```
```bash
docker push ghcr.io/hexapodbionik/elkapod_sim:latest
```

