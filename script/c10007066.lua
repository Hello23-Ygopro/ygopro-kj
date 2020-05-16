--Shaman Broccoli
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	for i=1,eg:GetCount() do
		--power up
		aux.AddTempEffectUpdatePower(c,c,1,3000)
	end
end
