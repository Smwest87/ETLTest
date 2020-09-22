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
        return result.json()
        
    def get_by_names(self):
        self.parser.add_argument("-p", "--primary", help="Primary Character Name")
        self.parser.add_argument("-s", "--secondary", help="Secondary Character Name")
        args = self.parser.parse_args()

        primary_name = args.primary
        if '-' in args.primary:
            primary_name = args.primary.replace("-", " ")

        secondary_name = args.secondary
        if '-' in args.secondary:
            secondary_name = args.secondary.replace("-", " ")

        params = {
            'apikey': self.public_key,
            'ts': str(self.timestamp),
            'hash': self.hash,
            'name': primary_name
        }

        secondary_params = {
            'apikey': self.public_key,
            'ts': str(self.timestamp),
            'hash': self.hash,
            'name': secondary_name
        }
        primary_result = requests.get(self.character_endpoint, params)
        secondary_result = requests.get(self.character_endpoint, secondary_params)
        return primary_result.json(), secondary_result.json()

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

        result = requests.get(self.character_endpoint, params)
        json_result = result.json()
        total_heroes = json_result['data']['total']

        for hero in json_result['data']['results']:
            heroes.append(hero['name'])

        counter = limit 
        offset += limit
        params.update({'offset': offset})

        while counter < total_heroes:
            params.update(offset=offset)
            loop_result = requests.get(self.character_endpoint, params)
            json_loop_result= loop_result.json()
            for hero in json_loop_result['data']['results']:
                heroes.append(hero['name'])
            counter += limit 
            offset += limit
        return heroes

    def hero_with_most_comics(self):
        heroes = []
        offset = 0
        limit = 100
        params = {
            'limit': limit,
            'offset': offset,
            'apikey': self.public_key, 
            'ts': self.timestamp,
            'hash': self.hash}

        result = requests.get(self.character_endpoint, params)
        json_result = result.json()
        total_heroes = json_result['data']['total']

        for hero in json_result['data']['results']:
            heroes.append({
                'name': hero['name'],
                'number': hero['comics']['available']
            })

        counter = limit 
        offset += limit
        params.update({'offset': offset})
        most_comics = {
            'name': "",
            'number': 0
        }
        while counter < total_heroes:
            params.update(offset=offset)
            loop_result = requests.get(self.character_endpoint, params)
            json_loop_result= loop_result.json()
            for hero in json_loop_result['data']['results']:
                if hero['comics']['available'] > most_comics['number']:
                    most_comics['number'] = hero['comics']['available']
                    most_comics['name'] = hero['name']
            counter += limit 
            offset += limit
        return most_comics

    def get_all_comic_ids(self, id, total_comics):
        limit = 100
        offset = 0
        counter = 0
        comics = []
        comic_endpoint = ("%s/%d/comics" %(self.character_endpoint, id))
        while counter < total_comics:
            params = {
            'limit': limit,
            'offset': offset,
            'apikey': self.public_key,
            'ts': str(self.timestamp),
            'hash': self.hash
            }

            comics_result = requests.get(comic_endpoint, params)
            json_comics_result = comics_result.json()
            for comic in json_comics_result['data']['results']:
                comics.append(comic['id'])
            
            counter += limit
            offset += limit

        return comics

    
    def find_comics_with_overlapping_heroes(self):
        primary_json, secondary_json = self.get_by_names()

        shared_ids = []
        #Get id for Primary and Secondary Hero
        primary_id = primary_json['data']['results'][0]['id']
        total_primary_comics = primary_json['data']['results'][0]['comics']['available']

        secondary_id = secondary_json['data']['results'][0]['id']
        total_secondary_comics = secondary_json['data']['results'][0]['comics']['available']
        
        primary_comics = self.get_all_comic_ids(primary_id, total_primary_comics)
        secondary_comics = self.get_all_comic_ids(secondary_id, total_secondary_comics)        

        for comic in primary_comics: 
            if comic in secondary_comics:
                shared_ids.append(comic)

        
        args = self.parser.parse_args()

        share_comics = {
            'primary': args.primary, 
            'secondary': args.secondary,
            'share_ids': shared_ids
        }

        return share_comics
        
finder = CharacterFinder()
heroes = finder.fetch_all_characters()
print(heroes)
most_comics = finder.hero_with_most_comics()
print(most_comics)
shared_comics = finder.find_comics_with_overlapping_heroes()
print(shared_comics)





