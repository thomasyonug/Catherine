structure Absyn =
struct


    type pos = int

    datatype operator = PLUS | DIV | MUL | MINUS | LT | GT | EQ

    and var = ID of string
    
    and exp = NilExp
            | NumberExp of int
            | XmlContentExp of string
            | operatorExp of {first: exp, second: exp, operator: operator}
            | DefineExp of {symbol: var, value: exp}
            | LambdaExp of {args: var list, body: exp list}
            | CondExp of (exp * exp) list
            | XmlExp of {tagName: string, children: exp list}


end