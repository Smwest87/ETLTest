import requests
from datetime import datetime
import argparse
import hashlib 
import os

class CharacterFinder:
    def __init__(self):
        
        self.character_endpoint = 'http://gateway.marvel.com/v1/public/characters'
        self.parser = argparse.ArgumentParser()
        self.timestamp = str(datetime.now())
        self.public_key = os.getenv("MARVEL_PUBLIC_KEY")
        self.private_key = os.getenv("MARVEL_PRIVATE_KEY")
        self.concat_string = self.timestamp + self.private_key + self.public_key
        self.hash = (hashlib.md5(self.concat_string.encode())).hexdigest()

    def get_by_id(self, id):
        endpoint = self.character_endpoint + '/' + str(id)
        params = {
            'apikey': self.public_key, 
            'ts': str(self.timestamp),
            'hash': self.hash}


        result = requests.get(endpoint, params)
        print(result.json())
        
    def get_by_name(self):
        self.parser.add_argument("-c", "--character", help="Character Name")
        args = self.parser.parse_args()
        character_name = args.character
        params = {
            'apikey': self.public_key,
            'ts': str(self.timestamp),
            'hash': self.hash,
            'name': character_name
        }
        
        result = requests.get(self.character_endpoint, params)
        print(result.json())

    def fetch_all_characters(self):
        heroes = []
        offset = 0
        limit = 100
        params = {
            'limit': limit,
            'offset': offset,
            'apikey': self.public_key, 
            'ts': self.timestamp,
            'hash': self.hash}

        hero_with_most_comics = {'name': None, 'number': 0}

        result = requests.get(self.character_endpoint, params)
        json_result = result.json()
        total_heroes = json_result['data']['total']

        for hero in json_result['data']['results']:
            heroes.append(hero['name'])

        if hero['comics']['available'] > hero_with_most_comics['number']:
            hero_with_most_comics['number'] = hero['comics']['available']
            hero_with_most_comics['name'] = hero['name']

        counter = limit 
        offset += limit
        params.update({'offset': offset})

        while counter < total_heroes:
            params.update(offset=offset)
            loop_result = requests.get(self.character_endpoint, params)
            json_loop_result= loop_result.json()
            for hero in json_loop_result['data']['results']:
                heroes.append(hero['name'])
            if hero['comics']['available'] > hero_with_most_comics['number']:
                hero_with_most_comics['number'] = hero['comics']['available']
                hero_with_most_comics['name'] = hero['name']
            counter += limit 
            offset += limit
        
        print(heroes)
        print(hero_with_most_comics)


finder = CharacterFinder()
finder.get_by_id(1011334)
finder.get_by_name()
finder.fetch_all_characters()




