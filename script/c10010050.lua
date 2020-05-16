--Chief Toko
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--protector
	aux.EnableProtector(c)
	--power up
	aux.EnableUpdatePower(c,3000,scard.con1)
	aux.AddEffectDescription(c,0,scard.con1)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
end
--power up, double breaker
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetShieldCount(tp)>=Duel.GetShieldCount(1-tp)
end
