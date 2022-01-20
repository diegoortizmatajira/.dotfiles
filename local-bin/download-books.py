#!/usr/bin/env python
import sys
from bs4 import BeautifulSoup
import requests
from colorama import Fore, Style


def main(book: str):
    base_url = search_zlib_base_url()
    search_zlib_book(base_url, book)


def search_zlib_base_url():
    response = requests.get('https://z-lib.org')
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    books_link = soup.find('a', text='Books', attrs={
                           'class': 'domain-check-link'
                           })
    if books_link == None:
        return None
    url = books_link['href']
    return 'https:' + url if url[:2] == "//" else url


def search_zlib_book(base_url: str, book: str):
    url = f"{base_url}/s/{book}/?e=1&extensions[]=epub"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    entries = soup \
        .find_all('tr', attrs={'class': 'bookRow'}, limit=10)
    for entry in entries:
        title_section = entry.find('h3', attrs={'itemprop': 'name'})
        title_link = title_section.find('a')
        title = title_link.text.strip()
        author = entry \
            .find('div', attrs={'class': 'authors'}) \
            .text.strip()

        file_section = entry.find('div', attrs={'class': 'property__file'})
        file_size = file_section \
            .find('div', attrs={'class': 'property_value'}) \
            .text.strip()
        print(f"{Fore.BLUE}{title}")
        print(f"{Fore.CYAN}{author}{Style.RESET_ALL}")
        print(
            f"[{file_size}]{Style.RESET_ALL} => {Fore.GREEN}{base_url}{title_link['href']}{Style.RESET_ALL}")
        print(f"{Style.DIM}---------------------------{Style.RESET_ALL}")


if __name__ == '__main__':
    if len(sys.argv) <= 1:
        print('You need to provide a book name')
        exit
    else:
        main(sys.argv[1])
