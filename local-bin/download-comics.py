#!/usr/bin/env python
import sys
from typing import Any, Dict
# from zippyshare_downloader import extract_info
from bs4 import BeautifulSoup
import requests
import re
from datetime import date, timedelta
from calendar import WEDNESDAY
from colorama import Fore, Style

def post_search(url: str) -> str | None:
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    post = soup.find('h1', {'class': 'post-title'})
    if post == None:
        return None
    link = post.find('a')
    if link == None:
        return None
    print(f'*************** {link.text} ***************')
    return link['href']


def download_link_search(url: str, filter: str) -> Dict[str, Any] | None:
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    webp_title = soup.find('span', text='WEBP')
    if webp_title == None:
        return None
    webp_section = webp_title.parent
    if webp_section == None:
        return None
    book_list = webp_section.findNextSibling('ul')
    if book_list == None:
        return None
    books = book_list.findAll('li')
    if books == None:
        return None
    result = {}
    for book_pack in books:
        pack_title = book_pack.find(text=True, recursive=False)
        if pack_title == None:
            continue
        match = re.search(filter, pack_title.replace(':', '').strip())
        if match == None:
            continue
        extracted_links = {}
        links = book_pack.findAll('a')
        if links == None:
            return None
        for link in links:
            if link.has_attr('href'):
                extracted_links[link.text.strip()] = link['href']
        result[pack_title] = extracted_links
    return result


def download_link_processor(links, priority, download):
    for book, urls in links.items():
        links_found = False
        for source in priority:
            url = urls.get(source, None)
            if url == None:
                continue
            print(f'>> Download: {Fore.BLUE}{book}{Style.RESET_ALL} [{Fore.CYAN}{source}{Style.RESET_ALL}] => {Fore.GREEN}{url}{Style.RESET_ALL}')
            links_found = True
            if download:
                pass
            break
        if not links_found:
            print(f'>> {Fore.YELLOW}Download{Style.RESET_ALL}: {Fore.BLUE}{book}{Style.RESET_ALL} => {Fore.RED}No url{Style.RESET_ALL}')


def download_week(delta: int = 0, download: str = 'y'):
    today = date.today()
    offset = (today.weekday() - WEDNESDAY) % 7
    last_wednesday = today - timedelta(days=offset)
    day_for_download = last_wednesday - timedelta(days=7*delta)
    date_string = day_for_download.strftime('%Y %m %d')
    url = f'https://getcomics.info/?s={date_string}+weekly'
    filter = 'Marvel|DC'
    priority = ['Zippyshare', 'Mediafire']
    comic_url = post_search(url)
    if comic_url == None:
        return
    links = download_link_search(comic_url, filter)
    if links == None:
        return
    download_link_processor(links, priority, download)


def main(delta_from=0, delta_to=0, download='y'):
    for delta in range(delta_from, delta_to+1):
        download_week(delta, download)


if __name__ == '__main__':
    delta_from = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    delta_to = int(sys.argv[2]) if len(sys.argv) > 2 else 0
    download = sys.argv[3] if len(sys.argv) > 3 else 'y'
    main(delta_from, delta_to, download)
