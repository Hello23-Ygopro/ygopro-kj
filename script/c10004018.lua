--Neuron's Oracle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm deck
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopConfirmOperation(PLAYER_ALL,1))
end
