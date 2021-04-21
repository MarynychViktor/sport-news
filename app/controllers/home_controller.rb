class HomeController < ApplicationController
  def index
    @heroes = [
      {
        group: "NBA",
        logo: "https://e0.365dm.com/19/10/2048x1152/skysports-nba-sky-live-live-on-sky_4810101.jpg",
        published: '10.09.2019',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
      },
      {
        group: "NBA",
        logo: "https://api.time.com/wp-content/uploads/2020/07/nba-restart.jpg",
        published: '21.03.2010',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
      },
      {
        group: "NBA",
        logo: "https://a.espncdn.com/photo/2020/0813/nba_mega_playoff_orange_HT_16x9.jpg",
        published: '12.05.2021',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
      },
      {
        group: "NBA",
        logo: "https://www.gannett-cdn.com/presto/2020/03/12/USAT/5746e69e-ed6a-4f4c-b175-f9c9b1d99e63-USP_NBA__Boston_Celtics_at_Utah_Jazz.JPG",
        published: '12.01.2015',
        title: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
        text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
      }
    ]
  end
end
