program Hello;
const
    STACK_SIZE = 1000;
var
    stack: Array[0..STACK_SIZE] of Char;
    topPointer: Integer;
    c: Char;
    valid: Boolean;
    part1: Int64;
    part2: Array[0..STACK_SIZE] of Int64;
    numValid: Integer;
    tmp: Int64;
    i, j: Integer;
begin
    stack[0] := 'x';
    topPointer := 1;
    valid := true;
    part1 := 0;
    numValid := 0;
    while not eof do
        begin
            read(c);
            if c = AnsiChar(#10) then begin
                if valid then begin
                    part2[numvalid] := 0;
                    for i := topPointer-1 downto 1 do begin
                        part2[numValid] := part2[numValid] * 5;
                        if stack[i] = ')' then part2[numValid] := part2[numValid] + 1
                        else if stack[i] = ']' then part2[numValid] := part2[numValid] + 2
                        else if stack[i] = '}' then part2[numValid] := part2[numValid] + 3
                        else if stack[i] = '>' then part2[numValid] := part2[numValid] + 4;
                    end;
                    numValid := numValid + 1;
                end;
                valid := true; 
                topPointer := 1; 
            end else if valid = false then
                continue
            else if c = '(' then begin
                stack[topPointer] := ')';
                topPointer := topPointer + 1;
            end else if c = '[' then begin
                stack[topPointer] := ']';
                topPointer := topPointer + 1;
            end else if c = '{' then begin
                stack[topPointer] := '}';
                topPointer := topPointer + 1;
            end else if c = '<' then begin
                stack[topPointer] := '>';
                topPointer := topPointer + 1;
            end else if c = stack[topPointer - 1] then
                topPointer := topPointer - 1
            else if c = ')' then begin
                part1 := part1 + 3;
                valid := false;
            end else if c = ']' then begin
                part1 := part1 + 57;
                valid := false;
            end else if c = '}' then begin
                part1 := part1 + 1197;
                valid := false;
            end else if c = '>' then begin
                part1 := part1 + 25137;
                valid := false;
             end;
        end;
    writeln(part1);

    { Bubble sort }
    for i := 0 to numValid-1 do begin
        for j := 0 to i-1 do begin
            if part2[i] < part2[j] then begin
                tmp := part2[i];
                part2[i] := part2[j];
                part2[j] := tmp;
            end;
        end;
    end;
    writeln(part2[numValid div 2]);
end.
