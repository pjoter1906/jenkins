# Użyj oficjalnego obrazu Pythona
FROM python:3.9-slim

RUN apt update && apt install -y git

WORKDIR /app

# Sklonowanie repo
RUN git clone https://github.com/vyahello/snakegame-gui.git .

RUN pip install --upgrade pip && pip install -r requirements.txt

# Ustawienie komendy startowej
CMD ["python", "pysnake.py"]
