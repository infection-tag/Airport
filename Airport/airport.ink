In an airport...
    -> sensory

// spawn info starts here    
=== sensory ===
You awake, suddenly. "Where am I?", you think to yourself. Your back feels like butter after awaking on such a hard bench. You think about what to do now.
    * Go back to sleep.
        -> nap
    * Look around.
        -> describe_the_spawn

=== nap ===
You don't know where you are or what you are doing here, but you just feel SO TIRED. You go back to bed as the hustle and bustle around you continues.
    -> sensory
    
=== describe_the_spawn ===
You get up and crack your back. It feels a little better. You look at your current "bed". There is a snow jacket, which you were using as a blanket, and a backpack.
    -> spawn_options
    
=== spawn_options ===
    * Check the pockets of the snow jacket
        -> snow_jacket
    * Check the backpack
        -> spawn_inventory
    -> late_for_flight
    
=== snow_jacket ===
Inside the snow jacket's pockets are: $5 and a plane ticket to New Dehli.
What do you do next?
VAR money = 5
    * Look around more
        -> spawn_options
    * Look at the plane ticket
        -> late_for_flight
    
=== spawn_inventory ===
There is nothing inside the backpack. What do you do next? 
    * Check the snow jacket.
        -> snow_jacket
    * Look around more
        -> late_for_flight
    
=== late_for_flight ===
You examine your plane ticket. The boarding time is 3:30... and the time is 3:00!
What do you do next?
    * Rush to the gate
        -> rush_to_gate
    * Get something to eat
        You think you have time. You go to the nearest restaurant.
        -> spawn_bite
        
=== rush_to_gate ===
You grab your bag and run to the gate. You check in, and get your boarding pass. Once you are on the flight, you think to yourself... what was I doing there? Where am I? Who am I? You check your boarding pass, and read the name.
    -> name

=== spawn_bite ===
// Something feels off. Have you been here before?
You have {money} dollars. What do you do now?
    + Buy a donut (1 dollar).
        ~ money = money - 1.
        You buy a donut. {&As the sweetness hits your tongue, you feel rejuvenated.|You taste the flavour, feeling less and less starving.|As you consume your third donut, you think to yourself, <i>I should probably head to my flight.</i>|As you consume your fourth donut, you realize you should probably head to your flight.|As you consume a fifth donut, you realize you are out of money because you foolishly spent it all on donuts. Also, you should definetely head to your flight now.}
        -> spawn_bite
    * Leave the restaurant.
        -> rush_to_gate
        
=== name ===
Your name seems to be Robert York and you were just in San Diego. You feel something inside your snow jacket. There seems to be a prepaid card that wasn't there before. Why are you here? Your back starts to throb again. You wait for the flight to finish taking off and lean back. Quickly, you doze off.
    VAR card_balance = 5000
    VAR in_airport = 1
    VAR location = "New Dehli" // the first location you go to.
    -> landing

// generic landing implementation
=== landing ===
You wake up, as a flight attendant gently pats you on the shoulder. "Sir", she says, "we are landing." You lift your chair back upright and wait for the flight to land. Once you are there, you exit the flight. You are now in {location}. What do you do next?
    
    + Find an ATM to withdraw money
        -> atm
    * Leave the airport
        ~ in_airport = 0
        -> outside_airport

=== outside_airport ===
You are now outside {location} International Airport.
    { location == "New Dehli": // you are in the first location, New Dehli.
        -> new_dehli
    - else:
        -> END
TODO: Add other airport diverts after New Dehli.
    }
    
// New Dehli path starts here.
=== new_dehli ===
~ in_airport = 0
You breathe a sigh outside, and wave for a taxi. It stops.
    + Get in.
        You enter the taxi.
        -> new_dehli_taxi
    + "Never Mind..."
        The driver looks at you sorely, and says something in Hindi. He drives off.
        What do you do now?
        ++ Walk to the nearest hotel
            -> new_dehli_walk
        ++ Call another taxi
            -> new_dehli
TODO: Add more about New Dehli here.

=== new_dehli_walk === 
"It's probably better not to waste your money on a ride, right?", you think to yourself as you navigate the city. -> hungry

=== new_dehli_taxi === // taxi ride to the airport
The man says something in a foreign language.
    + "What did you say?"
        The man sighs. He says. "Hello. Where is your destination?".
        ** "I want to eat something."
            "Okay", he says. Within 5 minutes, you two arrive at a street full of people. You pay him three dollars and exit the cab.
            ~ money = money - 3
            -> hungry
        ** "Can you take me to the nearest hotel?"
            "Okay", he says, and you two set off. In a couple of minutes, you arrive in front of a Best Western. Not exactly what you had in mind, but you'll take it. You pay him $3 and get out of the cab.
            ~ money = money - 3
            -> hotel
    + "Sorry, I only speak English."
        The man sighs. He says. "Hello. Where is your destination?".
        ** "I want to eat something."
            "Okay", he says. Within 5 minutes, you two arrive at a street full of people. You pay him three dollars and exit the cab.
            ~ money = money - 3
            -> hungry
        ** "Can you take me to the nearest hotel?"
            "Okay", he says, and you two set off. In a couple of minutes, you arrive in front of a Best Western. Not exactly what you had in mind, but you'll take it. You pay him $3 and get out of the cab.
            ~ money = money - 3
            -> hotel
    * Nod and pretend to understand what he is saying.
        The man looks at you in confusion. -> new_dehli_taxi
    
=== new_dehli_hotel ===
This part is still under developement! -> END
TODO: Add part about the Best Western.

=== hungry === // Eating out happens here
 There is a lot of street life here, and the hotel is a couple of miles off. Your stomach growls. There are restaurants and street stands all around you. To which do you go?
    * Street Food
        You go to a stand on the street. It smells delicious. Someone randomely hands you a plate of delicious-smelling soup. They ask for your money. It costs $5. You have {money} dollars. What do you do now?
                ** Pay
                    { money >= 5:
                        ~ money = money - 5
                        You pay the 5 dollars and eat your food. It's delicious. You continue walking to the hotel. -> hotel
                    - else:
                        You don't have enough money to do this. What do you do next?
                            ** return the food
                                You return the food. You are still hungry. What do you do next?
                                        *** Get something to eat -> hungry
                                        *** Continue to the hotel -> hotel
                            ** run!
                                You start running to the hotel, food in hand. No one chases you, although you can hear the owner yell after you. Once you think you are safe, you eat the food and sigh. It's delicious. You should have payed them. Too bad you didn't have enough money! -> hotel
                    }
    * Restaurant
        You walk into a restaurant. It feels nice inside. You sit down, and let the soft music relax you. A waiter comes up to you, and asks you if you want to order something.  -> END

// ATM implementation starts here
=== atm ===
You walk up to an ATM and swipe your trusty card. It reads:
BALANCE: USD{card_balance}
You currently have {money} dollars.
Would you like to withdraw or load balance?
    + withdraw
        How much would you like to withdraw?
            ** 5
                You have withdrawn 5 dollars.
                ~ card_balance = card_balance - 5
                ~ money = money + 5
                Your new balance is ${card_balance} and you have ${money} in hand.
                { in_airport == 1: // checks where player is
                    -> outside_airport
                - else:
                    -> hotel
                }
            ** 10
                ~ card_balance = card_balance - 10
                ~ money = money + 10
                Your new balance is ${card_balance} and you have ${money} in hand.
                { in_airport == 1: // checks where player is
                    -> outside_airport
                - else:
                    -> hotel
                }
            ** 25
                ~ card_balance = card_balance - 25
                ~ money = money + 25
                Your new balance is ${card_balance} and you have ${money} in hand.
                { in_airport == 1: // checks where player is
                    -> outside_airport
                - else:
                    -> hotel
                }
            ** 100
                ~ card_balance = card_balance - 100
                ~ money = money + 100
                Your new balance is ${card_balance} and you have ${money} in hand.
                { in_airport == 1: // checks where player is
                    -> outside_airport
                - else:
                    -> hotel
                }
TODO: Add load balance implementation here, as well as cap to withdrawal money (making sure player can't withdraw more money than is on their prepaid card.)

// Hotel implementation starts here
=== hotel ===
-> END
You enter the hotel.
    { location == new_dehli:
        -> new_dehli_hotel
    - else:
        -> END
    }