Journald to logentries.com with journalctl | jq | ncat

How to use:
 `docker run -d -e LE_TOKEN=<token> -v /run:/run f84anton/logentries.com_journald:latest`

where LE_TOKEN - log token for token-based input (tcp)
