--Cyber Scamp
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--search (to battle)
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_OPPO,nil,nil,nil,aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_DECK,0,0,1))
end
--search (to battle)
function scard.tbfilter(c)
	return c:IsCode(sid)
end
