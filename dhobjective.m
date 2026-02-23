function err = dhobjective(para, data, target_positions)

d1 = 3.2;
a1 = 10.5;
d2 = 0.5;
a2 = 10.3;
para = [d1, a1, d2, a2];

L(1) = Link('revolute', 'd', 3.2, 'a', 10.5, 'alpha', 0, 'offset', 8*pi/180);
L(2) = Link('revolute', 'd', 0.5, 'a', 10.3, 'alpha', 180*pi/180, 'offset', 25*pi/250);
L(3) = Link('prismatic', 'theta', 0, 'a', 0, 'alpha', 0, 'offset', -3);

marge = SerialLink([L(1) L(2) L(3)], 'name', 'marge');

err = 0;

for i = 1:size(data,1)
    qn = data(i,:);
    T = marge.fkine(qn);
    newpos = T(1:3,4);
    pos = target_positions(i,:)';
    err = err + sum((pos - newpos).^2);
end
err = err/size(data,1);
end
