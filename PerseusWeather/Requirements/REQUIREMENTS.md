<!--

REQUIREMENTS.md
PerseusWeather

Created by Mikhail Zhigulin in 7531.

Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk
Copyright © 7531 - 7532 PerseusRealDeal

The year starts from the creation of the world according to a Slavic calendar.
September, the 1st of Slavic year.

See LICENSE for details. All rights reserved.

-->
> # The App's Name: Weather

> # Idea history

<table>
    <tr>
        <th>Related to versions</th>
        <th>Short description</th>
    </tr>
    <tr>
        <td>0.2</td>
        <td>Developer release (candidate) with minimum functionality (current weather).</td>
    </tr>
</table>

> # Business Tasks:

| ID   | Description                 | Operations |
| ---- | --------------------------- | ---------- |
| BT-1 | Fetching weather forecast   | OP-1, OP-2 |

> # Sketches (GUI requirements)

- The app should look like it presented in the picture below. 

<img src="Sketches/StatusMenusItemSketch.png" width="400" style="max-width: 100%; display: block; margin-left: auto; margin-right: auto;"/>

- The app should have no menu and no icon in Dock, but starts as a Status Menus app only. 
- A typical window should be employed for preferences.

> # User Stories

<table>
    <tr>
        <th>ID</th>
        <th>Description</th>
    </tr>
    <tr>
        <td nowrap>US-1</td>
        <td>As Mikhail, I want to be aware of the current weather condition both in short and in detail as well, so I can feel more in selfcare.</td>
    </tr>
    <tr>
        <td nowrap>US-2</td>
        <td>As Mikhail, I want to be able to call weather condition again, so I can be sure about the current weather.</td>
    </tr>
    <tr>
        <td nowrap>US-3</td>
        <td>As Mikhail, I want to be able to adjust the app preferences, so I can feel more comfortable in the app usage.</td>
    </tr>
    <tr>
        <td nowrap>US-4</td>
        <td>As Mikhail, I want to be able to quit the app, so I can feel more comfortable in the app usage.</td>
    </tr>
</table>

> # Specials

| ID   | Description | Data |
| ---- | ----------- | ---- |
| SP-1 | Dark Mode   | OO-1 |

> # Operations

| ID   | Description                               | Must have  | Data                 | Rules  |
| ---- | ----------------------------------------- | ---------- | -------------------- | ------ |
| OP-1 | Call current weather with OpenWeather API | API key    | DATA-1, DATA-2, OO-2 | RULE-1 |
| OP-2 | Ask for current location                  | Permission | DATA-2               | - |

> # Rules

| ID     | Description                                        |
| ------ | -------------------------------------------------- |
| RULE-1 | Generally accepted temperature converting formulas |

> # Data Models

> ## Business matter attributes

| ID     | Name             | Details                                                 | Defaults        |
| ------ | ---------------- | ------------------------------------------------------- | --------------- |
| DATA-1 | Temperature      | Standard: Kelvin, Metric: Celsius, Imperial: Fahrenheit | Apply: Celsius  |
| DATA-2 | Current location | Couple: (latitude, longitude)                           | - |

> ## Other Options

| ID   | Name                | Details          | Defaults    |
| ---- | ------------------- | ---------------- | ----------- |
| OO-1 | Dark Mode           | Auto, On, Off    | Apply: Auto |
| OO-2 | OpenWeather API key | User Input       | -           |
| OO-3 | Starts on login     | True, False      | Apply: True |
