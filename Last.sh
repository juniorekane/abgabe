#!/usr/bin/env bash
while true; do
        docker_stats=$(docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}")
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
while IFS= read -r line; do
    echo "$line - $current_datetime"
done <<< "$docker_stats" >> docker_Sharding_6000.txt
sleep 1
done
