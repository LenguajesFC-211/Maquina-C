module TinyC where 
 import Data.Maybe

 type Identificador = String

 -- Expresiones
 data Expr = Num Int
            | Bo Bool
            | Id Identificador
            | Fun [Identificador] Stmt
            | Suma Expr Expr
            | Resta Expr Expr
            | Gt Expr Expr
            | Lt Expr Expr
            | Funcall Identificador [Expr]
            deriving(Show,Eq)
 -- Comandos 
 data Stmt = Vardec Identificador Expr
            | Fundec Identificador [Identificador] Stmt
            | Asig Identificador Expr
            | Secu Stmt Stmt
            | If Expr Stmt Stmt
            | IfO Expr Stmt
            | While Expr Stmt 
            | Return Expr
            | MtP
            deriving(Show,Eq)

 type Program = Either Expr Stmt

 -- Valores para almacenar en el ambiente
 data Value = N Int | B Bool | F [Identificador] Stmt deriving(Show,Eq)

-- Sinónimo para definir los pares de variables con su valor que se almacenan en el ambiente
 type Var = (Identificador,Value)

-- Ambientes
 data Env = MtEnv | As Var Env | Star Env Env deriving(Show,Eq)

-- Marcos de la pila
 data Marco = VardecM Identificador
            | AsigM Identificador
            | SecuM Stmt
            | IfM Stmt Stmt
            | IfOM Stmt
            | ReturnM 
            | FuncallM Identificador
            deriving(Show,Eq) 

-- Pila de control
 data Pila = Mt | Top Marco Pila deriving(Show,Eq)

-- Estados de la Máquina C
 data State = E Pila Env Env Program | R Pila Env Env Program deriving(Show,Eq)