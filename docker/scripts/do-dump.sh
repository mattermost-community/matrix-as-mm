docker-compose exec  postgres bash   ./dump_db.sh
docker-compose cp postgres:/backup/ ./
ls -l ./backup
