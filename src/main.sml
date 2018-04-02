
structure Catherine = Server (
    structure Conn = DefaultConn;
    structure Parser = DefaultParser;
    structure Poll = DefaultPoll;
);