import requests
from bs4 import BeautifulSoup
import json

def get_instagram_profile(username):
    url = f'https://www.instagram.com/{username}/'
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
    }
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        script_tags = soup.find_all('script', type="text/javascript")
        for script in script_tags:
            if script.string and 'window._sharedData' in script.string:
                shared_data = script.string.split(' = ', 1)[1].rstrip(';')
                profile_data = json.loads(shared_data)['entry_data']['ProfilePage'][0]['graphql']['user']

                name = profile_data['full_name']
                profile_pic_url = profile_data['profile_pic_url_hd']

                return {
                    'name': name,
                    'profile_pic_url': profile_pic_url
                }
        print('Failed to find the required script tag')
        return None
    else:
        print(f'Failed to retrieve the page, status code: {response.status_code}')
        return None

if __name__ == '__main__':
    username = 'arabkmr'
    profile = get_instagram_profile(username)
    if profile:
        print(f"Name: {profile['name']}")
        print(f"Profile Picture URL: {profile['profile_pic_url']}")
