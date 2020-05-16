--Beam Bloom
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STAR_SENTINEL,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.TurnPlayerCondition(PLAYER_OPPO),LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf())
end
