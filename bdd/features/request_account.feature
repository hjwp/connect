Feature: Request Account
    As a member of the public
    I want to apply for an account
    So that I can use this application

    Background: There are two users in the database
        Given there is a standard user in the database
        And there is a closed user in the database

    Scenario Outline: User submits data to the request account form
        Given I am "an unknown user"
        When I visit the "request account" page
        And I enter "<full name>" into the "full name" field
        And I enter "<email>" into the "email" field
        And I enter "<comments>" into the "comments" field
        And I submit the form
        Then I see "<message>"

        Examples:
            |   full name   |   email                       |   comments    |   message                                                                 |
            |   ""          |   request.account@test.test   |   comment     |   Please enter your full name.                                            |
            |   First Last  |   ""                          |   comment     |   Please enter your email address.                                        |
            |   First Last  |   request.account@test.test   |   ""          |   Please describe why you would like to create an account.                |
            |   First Last  |   invalidemail                |   comment     |   Please enter a valid email address.                                     |
            |   First Last  |   standard.user@test.test     |   comment     |   Sorry, this email address is already registered to another user.        |
            |   First Last  |   closed.user@test.test       |   comment     |   This email address is already registered to another (closed) account.   |
            |   First Last  |   request.account@test.test   |   comment     |   Your request for an account has been sent                               |

    Scenario: User cancels attempt to request new account
        Given I am "an unknown user"
        When I visit the "request account" page
        And I cancel the request account form
        Then I am redirected to the login page
