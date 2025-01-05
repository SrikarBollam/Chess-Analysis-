#!/usr/bin/env python
# coding: utf-8

# In[9]:


pip install python-chess pandas


# In[12]:


import chess.pgn
import pandas as pd


pgn_files = [
    r"C:\Temple\Data Analyst\PowerBI\Chess\1.pgn",
    r"C:\Temple\Data Analyst\PowerBI\Chess\2.pgn",
    r"C:\Temple\Data Analyst\PowerBI\Chess\3.pgn"]
csv_file = r"C:\Temple\Data Analyst\PowerBI\Chess\Srikar Games.csv"


data = []


for pgn_file in pgn_files:
    with open(pgn_file, 'r') as pgn:
        while True:
            game = chess.pgn.read_game(pgn)
            if game is None:
                break
            
            headers = game.headers
            data.append({
                "Event": headers.get("Event", ""),
                "Site": headers.get("Site", ""),
                "Date": headers.get("Date", ""),
                "Round": headers.get("Round", ""),
                "White": headers.get("White", ""),
                "Black": headers.get("Black", ""),
                "Result": headers.get("Result", ""),
                "WhiteElo": headers.get("WhiteElo", ""),
                "BlackElo": headers.get("BlackElo", ""),
                "ECO": headers.get("ECO", ""),
                "Opening": headers.get("Opening", ""),
                "Moves": game.board().variation_san(game.mainline_moves()),
            })

df = pd.DataFrame(data)
df.to_csv(csv_file, index=False)
print(f"PGN files converted to CSV and saved as {csv_file}")

