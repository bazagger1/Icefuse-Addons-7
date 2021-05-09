--[[
Server Name: ▌ Icefuse.net ▌ DarkRP 100k Start ▌ Bitminers-Slots-Unbox ▌
Server IP:   208.103.169.42:27015
File Path:   addons/[server]_slots_machine/lua/blues_slots_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

WOL_CONFIG = {}

WOL_CONFIG.antiTheftTime = 15
WOL_CONFIG.jackpotIncreasePerSpin = 250

//This is the minimal amount the jackpot can reset to
WOL_CONFIG.jackpotResetMin = 30000
WOL_CONFIG.jackpotResetMax = 40000 //2 mill is reasonable consider the rarity the jackpot should be.

//The amount it charges the user to per spin (It does not charge for the bonus spins as they are free)
WOL_CONFIG.pricePerSpin = 250 

//This is the icon used before displaying money ($, €, £)
WOL_CONFIG.currencyIcon = "$"

//This is the chances of each item appearing on the reel
//I tried my best to balance these but of course feel free to change them.
//The chance has to be a whole number and is calculated by "tickets"
//To work out the chance of S
WOL_ITEM_CHANCE[1] = 4   //Bonus (WARNING, MAKING THIS TO HIGH WILL CRUSH YOUR ECONOMY AS PEOPLE CAN SPIN FOR THE JACKPOT MANY TIMES)
WOL_ITEM_CHANCE[2] = 45  //Respberry --default value: 50
WOL_ITEM_CHANCE[3] = 25  //Coins --default value: 30
WOL_ITEM_CHANCE[4] = 9  //Diamond --default value: 10
WOL_ITEM_CHANCE[5] = 55  //Bar Two --default value: 60
WOL_ITEM_CHANCE[6] = 65  //Bar One --default value: 70
WOL_ITEM_CHANCE[7] = 50  //Seven --default value: 55
WOL_ITEM_CHANCE[8] = 65  //Nothing --default value: 65

//These are the payouts for each wining combination.
WOL_CONFIG.winning = {}

//Getting three bonus in a row (This includes 3 bonus spins too)
WOL_CONFIG.winning.threeBonus = 500

//Getting two bonus in a any position(This includes 3 bonus spins too)
WOL_CONFIG.winning.twoBonus = 250

//Getting one bonus in a any position(This includes 3 bonus spins too)
WOL_CONFIG.winning.oneBonus = 100

//Getting threE raspberrys in a row.
WOL_CONFIG.winning.threeRaspberry = 2500

//Getting three coins in a row
WOL_CONFIG.winning.threeCoins = 5000

//Getting two coins in a row
WOL_CONFIG.winning.twoCoins = 2500

//Getting three diamonds in a row
WOL_CONFIG.winning.threeDiamonds = 10000 

//Getting two diamons in any place
WOL_CONFIG.winning.twoDiamonds = 4500

//Getting one diamond in any place
WOL_CONFIG.winning.oneDiamonds = 1000  

//Getting three BAR2's in a row
WOL_CONFIG.winning.threeBar2 = 1750

//Getting three BAR'S in a row
WOL_CONFIG.winning.threeBar = 1000

//Getting three 7's in a row
WOL_CONFIG.winning.threeSeven = 2500

//These are the items on the bonus wheel, DO NOT ADD OR REMOVE ANY
//Only change the numbers.
WOL_AddBonusItem(200)
WOL_AddBonusItem(350)
WOL_AddBonusItem(400)
WOL_AddBonusItem(550)
WOL_AddBonusItem(600)
WOL_AddBonusItem(700)
WOL_AddBonusItem(800)
WOL_AddBonusItem(900)
WOL_AddBonusItem(1000)
WOL_AddBonusItem(1200)
WOL_AddBonusItem(1400)
WOL_AddBonusItem(1600)
WOL_AddBonusItem(1800)
WOL_AddBonusItem(2000)
WOL_AddBonusItem(2500)
WOL_AddBonusItem(3000)
WOL_AddBonusItem(4000)
WOL_AddBonusItem(4500)
WOL_AddBonusItem(5000)

//This is a list of ranks that can save machine places, using !saveslots
WOL_CONFIG.allowedRanks = {
	"superadmin",
	"c_e_o",
  
	"developer"
}


//ADVANCED

//If you want to change the currency it uses then you can do so with these two functions.
//The first checks if the player has enough money and the second one takes the money and the third one gives the money
//You can change what is inside of these functions incase you want to switch it to pointshop or a custom gamemode currency.

//Return try if yes, false if no
WOL_CONFIG.onCheckIfCanAfford = function(ply, amount)
	return ply:canAfford(amount)
end

//Take what ever currency you are using from the player
WOL_CONFIG.onPlayerTakeMoney = function(ply, amount)
	ply:addMoney(amount * -1) //Convert it to a negative number as thats how darkrp works.
end

//Add the money to the players bank for what ever currency you use.
WOL_CONFIG.onPlayerAddMoney = function(ply, amount)
	ply:addMoney(amount)
end

//Lastly I guess thanks for the purchase, it helps me so much! I hope you enjoy your addon!