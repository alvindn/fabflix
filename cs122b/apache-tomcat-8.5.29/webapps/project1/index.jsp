<%--
  Created by IntelliJ IDEA.
  User: alvindn
  Date: 4/13/18
  Time: 6:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Fablix</title>
        <link rel="stylesheet" href="main.css">
        <link href="https://fonts.googleapis.com/css?family=Merriweather:900|
        Raleway:500|Rubik|Philosopher:400|Inconsolata:400|Gugi:400|Muli|Anton|Mina" rel="stylesheet">
    </head>

    <body>
        <div id="header">
            <div class="logo">
                <a class="home" href="./">Fablix</a>
            </div>
            <div class="leftMenu">
                <ul>
                    <li>
                        <a class="moviesSelect" href="./searching">Advanced Search</a>
                    </li>
                    <li>
                        <a class="tv" href="./browse">Browse</a>
                    </li>
                    <li>
                        <a class="topRate" href="./movielist">Top 20 Rated</a>
                    </li>
                </ul>
            </div>
            <div class="rightMenu">
                <ul>
                    <li>
                        <a class="user" href="./cart">Checkout</a>
                    </li>
                </ul>
            </div>
        </div>
        <div id="top20">
            Top 20 Rated
        </div>
        <div id="movieTable">
            <table border="1">
            <div>
                <tr>
                <td class="mov">Movie Title</td>
                <td class="yr">Year</td>
                <td class="dir">Director</td>
                <td class="rat">Rating</td>
                <td class="star">Stars</td>
                <td class="genre">Genres</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title1}</td>
                <td class="facts">${year1}</td>
                <td class="facts">${director1}</td>
                <td class="facts">${rating1}</td>
                <td class="facts">${stars1}</td>
                <td class="facts">${genres1}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title2}</td>
                <td class="facts">${year2}</td>
                <td class="facts">${director2}</td>
                <td class="facts">${rating2}</td>
                <td class="facts">${stars2}</td>
                <td class="facts">${genres2}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title3}</td>
                <td class="facts">${year3}</td>
                <td class="facts">${director3}</td>
                <td class="facts">${rating3}</td>
                <td class="facts">${stars3}</td>
                <td class="facts">${genres3}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title4}</td>
                <td class="facts">${year4}</td>
                <td class="facts">${director4}</td>
                <td class="facts">${rating4}</td>
                <td class="facts">${stars4}</td>
                <td class="facts">${genres4}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title5}</td>
                <td class="facts">${year5}</td>
                <td class="facts">${director5}</td>
                <td class="facts">${rating5}</td>
                <td class="facts">${stars5}</td>
                <td class="facts">${genres5}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title6}</td>
                <td class="facts">${year6}</td>
                <td class="facts">${director6}</td>
                <td class="facts">${rating6}</td>
                <td class="facts">${stars6}</td>
                <td class="facts">${genres6}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title7}</td>
                <td class="facts">${year7}</td>
                <td class="facts">${director7}</td>
                <td class="facts">${rating7}</td>
                <td class="facts">${stars7}</td>
                <td class="facts">${genres7}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title8}</td>
                <td class="facts">${year8}</td>
                <td class="facts">${director8}</td>
                <td class="facts">${rating8}</td>
                <td class="facts">${stars8}</td>
                <td class="facts">${genres8}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title9}</td>
                <td class="facts">${year9}</td>
                <td class="facts">${director9}</td>
                <td class="facts">${rating9}</td>
                <td class="facts">${stars9}</td>
                <td class="facts">${genres9}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title10}</td>
                <td class="facts">${year10}</td>
                <td class="facts">${director10}</td>
                <td class="facts">${rating10}</td>
                <td class="facts">${stars10}</td>
                <td class="facts">${genres10}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title11}</td>
                <td class="facts">${year11}</td>
                <td class="facts">${director11}</td>
                <td class="facts">${rating11}</td>
                <td class="facts">${stars11}</td>
                <td class="facts">${genres11}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title12}</td>
                <td class="facts">${year12}</td>
                <td class="facts">${director12}</td>
                <td class="facts">${rating12}</td>
                <td class="facts">${stars12}</td>
                <td class="facts">${genres12}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title13}</td>
                <td class="facts">${year13}</td>
                <td class="facts">${director13}</td>
                <td class="facts">${rating13}</td>
                <td class="facts">${stars13}</td>
                <td class="facts">${genres13}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title14}</td>
                <td class="facts">${year14}</td>
                <td class="facts">${director14}</td>
                <td class="facts">${rating14}</td>
                <td class="facts">${stars14}</td>
                <td class="facts">${genres14}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title15}</td>
                <td class="facts">${year15}</td>
                <td class="facts">${director15}</td>
                <td class="facts">${rating15}</td>
                <td class="facts">${stars15}</td>
                <td class="facts">${genres15}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title16}</td>
                <td class="facts">${year16}</td>
                <td class="facts">${director16}</td>
                <td class="facts">${rating16}</td>
                <td class="facts">${stars16}</td>
                <td class="facts">${genres16}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title17}</td>
                <td class="facts">${year17}</td>
                <td class="facts">${director17}</td>
                <td class="facts">${rating17}</td>
                <td class="facts">${stars17}</td>
                <td class="facts">${genres17}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title18}</td>
                <td class="facts">${year18}</td>
                <td class="facts">${director18}</td>
                <td class="facts">${rating18}</td>
                <td class="facts">${stars18}</td>
                <td class="facts">${genres18}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title19}</td>
                <td class="facts">${year19}</td>
                <td class="facts">${director19}</td>
                <td class="facts">${rating19}</td>
                <td class="facts">${stars19}</td>
                <td class="facts">${genres19}</td>
                </tr>
            </div>
            <div>
                <tr>
                <td class="facts1">${title20}</td>
                <td class="facts">${year20}</td>
                <td class="facts">${director20}</td>
                <td class="facts">${rating20}</td>
                <td class="facts">${stars20}</td>
                <td class="facts">${genres20}</td>
                </tr>
            </div>
            </table>
        </div>
    </body>
</html>