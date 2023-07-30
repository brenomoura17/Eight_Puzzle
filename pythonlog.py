from pyswip import Prolog

prolog = Prolog()

# Carregar as regras e fatos usando consult()
prolog.consult("rules.pl")

# Consulta da solução
result = list(prolog.query("test(Plan)."))

if result:
    plan = result[0]["Plan"]
    print(plan)

#else:
    #print("Nenhuma solução encontrada.")
