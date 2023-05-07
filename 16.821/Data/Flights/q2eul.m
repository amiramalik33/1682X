function Euler = q2eul(q0, q1, q2, q3)
    
    elements = length(q0);

    Euler = zeros(elements, 3);

    for i = 1:elements
        quat = [q0(i), q1(i), q2(i), q3(i)];
        eulZYX = quat2eul(quat);
        Euler(i, 3) = eulZYX(1);
        Euler(i, 2) = eulZYX(2);
        Euler(i, 1) = eulZYX(3);
    end

end