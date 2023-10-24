close all 
clear all
warning off

a=[
    0 0 1 1 0 0;
    0 0 1 1 0 0;
    1 1 1 1 1 1;
    1 1 1 1 1 1;
    0 0 1 1 0 0;
    0 0 1 1 0 0
    ];
figure
imshow(a,'InitialMagnification','fit')

b = [
    1 1 1 1 1 1;
    1 0 0 0 0 0;
    1 1 1 1 1 0;
    1 0 0 0 0 0;
    1 1 1 1 1 1;
    0 0 0 0 0 0
];
figure
imshow(b,'InitialMagnification','fit')

c = [
    1 1 1 1 1 1;
    0 0 1 1 0 0;
    0 0 1 1 0 0;
    0 0 1 1 0 0;
    1 1 1 1 1 1;
    0 0 0 0 0 0
];
figure
imshow(c,'InitialMagnification','fit')

d = [
    0 1 1 1 1 0;
    1 0 0 0 0 1;
    1 0 0 0 0 1;
    1 0 0 0 0 1;
    0 1 1 1 1 0;
    0 0 0 0 0 0
];
figure
imshow(d,'InitialMagnification','fit')

e = [
    1 0 0 0 0 1;
    1 0 0 0 0 1;
    1 0 0 0 0 1;
    1 0 0 0 0 1;
    0 1 1 1 1 0;
    0 0 0 0 0 0
];
figure
imshow(e,'InitialMagnification','fit')

f = [
    1 1 0 0 1 1;
    1 1 0 0 1 1;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    1 1 0 0 1 1;
    1 1 0 0 1 1
];
figure
imshow(f,'InitialMagnification','fit')
 
A = [a(:,1); a(:,2); a(:,3); a(:,4); a(:,5); a(:,6)];
B = [b(:,1); b(:,2); b(:,3); b(:,4); b(:,5); b(:,6)];
C = [c(:,1); c(:,2); c(:,3); c(:,4); c(:,5); c(:,6)];
D = [d(:,1); d(:,2); d(:,3); d(:,4); d(:,5); d(:,6)];
E = [e(:,1); e(:,2); e(:,3); e(:,4); e(:,5); e(:,6)];
F = [f(:,1); f(:,2); f(:,3); f(:,4); f(:,5); f(:,6)];

P=[A, B, C, D, E, F];

T=[
    1 0 0 0 0 0;
    0 1 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1];

R=[zeros(36,1) ones(36,1)];

ip=[
    0 1 1 1 1 0;
    1 1 1 1 1 1;
    1 1 0 0 1 1;
    1 1 0 0 1 1;
    1 1 1 1 1 1;
    0 1 1 1 1 0
];

figure
imshow(ip,'InitialMagnification','fit')   
IP= [ip(:,1); ip(:,2); ip(:,3); ip(:,4); ip(:,5); ip(:,6)];

figure
subplot(3,3,1)
imshow(a,'InitialMagnification','fit')
subplot(3,3,2)
imshow(b,'InitialMagnification','fit')
subplot(3,3,3)
imshow(c,'InitialMagnification','fit')
subplot(3,3,4)
imshow(d,'InitialMagnification','fit') 
subplot(3,3,5)
imshow(e,'InitialMagnification','fit') 
subplot(3,3,6)
imshow(f,'InitialMagnification','fit')   
subplot(3,3,7)
imshow(ip,'InitialMagnification','fit')

net = newp(R,6);

Y = sim(net,P)

net.trainParam.epochs = 20;
net = train(net,P,T);

Y = sim(net,A)
Y = sim(net,B)
Y = sim(net,C)
Y = sim(net,D)
Y = sim(net,E)
Y = sim(net,F)

Y = sim(net,P)

Y = sim(net,IP)
