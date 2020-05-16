--Scaradorable the Hunter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability (cannot attack)
	aux.EnableEffectCustom(c,EFFECT_CANNOT_ATTACK,nil,0,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsManaCostBelow,2))
	--get ability (cannot block)
	aux.EnableEffectCustom(c,EFFECT_CANNOT_BLOCK,nil,0,LOCATION_BZONE,aux.TargetBoolFunction(Card.IsManaCostBelow,2))
end
