--Grove Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.TurnPlayerCondition(PLAYER_OPPO))
	aux.AddEffectDescription(c,0,aux.TurnPlayerCondition(PLAYER_OPPO))
end
