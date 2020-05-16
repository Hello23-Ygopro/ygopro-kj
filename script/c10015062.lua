--Batter-Axe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--break
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_SELF,1,1,c))
end
