#!/usr/bin/env python3
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
    if soup is None:
        return None
    post = soup.find('h1', {'class': 'post-title'})
    if post is None:
        return None
    link = post.find('a')
    if link is None:
        return None
    print(f'*************** {link.text} ***************')
    return link['href']


def download_link_search(url: str, filter: str) -> Dict[str, Any] | None:
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup is None:
        return None
    download_section_title = soup.find('span', string='WEBP')
    if download_section_title is None:
        # Then look for JPG downloads if no WEBP download is available.
        download_section_title = soup.find('span', string='JPG')

    download_section = None
    if download_section_title is not None:
        # look for h3 title that contains current JPG or WEBP span.
        download_section = download_section_title.parent
    else:
        # look for h2 title before any download links
        download_section = soup.find('h2', string='Free Comics Download')

    if download_section is None:
        return None
    # Finds the next list of files to download.
    book_list = download_section.findNext('ul')
    if book_list is None:
        print('found nothing')
        return None
    books = book_list.findAll('li')
    if books is None:
        return None
    result = {}
    for book_pack in books:
        pack_title = book_pack.find(string=True, recursive=False)
        if pack_title is None:
            continue
        match = re.search(filter, pack_title.replace(':', '').strip())
        if match is None:
            continue
        extracted_links = {}
        links = book_pack.findAll('a')
        if links is None:
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
            if url is None:
                continue
            print(
                f'>> Download: {Fore.BLUE}{book}{Style.RESET_ALL} [{Fore.CYAN}{source}{Style.RESET_ALL}] => {Fore.GREEN}{url}{Style.RESET_ALL}'
            )
            links_found = True
            if download:
                pass
            break
        if not links_found:
            print(
                f'>> {Fore.YELLOW}Download{Style.RESET_ALL}: {Fore.BLUE}{book}{Style.RESET_ALL} => {Fore.RED}No url{Style.RESET_ALL}'
            )


def download_week(delta: int = 0, download: str = 'y'):
    today = date.today()
    offset = (today.weekday() - WEDNESDAY) % 7
    last_wednesday = today - timedelta(days=offset)
    day_for_download = last_wednesday - timedelta(days=7 * delta)
    date_string = day_for_download.strftime('%Y %m %d')
    url = f'https://getcomics.info/?s={date_string}+weekly'
    filter = 'Marvel|DC'
    priority = ['MEDIAFIRE', 'ZIPPYSHARE']
    comic_url = post_search(url)
    if comic_url is None:
        return
    links = download_link_search(comic_url, filter)
    if links is None:
        return
    download_link_processor(links, priority, download)


def main(delta_from=0, delta_to=0, download='y'):
    for delta in range(delta_from, delta_to + 1):
        download_week(delta, download)


if __name__ == '__main__':
    delta_from = int(sys.argv[1]) if len(sys.argv) > 1 else 0
    delta_to = int(sys.argv[2]) if len(sys.argv) > 2 else 0
    download = sys.argv[3] if len(sys.argv) > 3 else 'y'
    main(delta_from, delta_to, download)
