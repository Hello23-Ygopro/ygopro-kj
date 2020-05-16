--Oozing Lavasaur
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TARBORG,RACE_ROCK_BRUTE)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,2000)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
end
