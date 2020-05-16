--Masked Gravewing
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--return
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1))
end
