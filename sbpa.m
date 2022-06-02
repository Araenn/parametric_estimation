function [y,time]=sbpa(Te, nr, p, a, n)
%
% G�n�re une SBPA en format STRUCTURE WITH TIME 
%
% Usage: 
% >  entree = sbpa(Te, nr, p, a, n)
%
% nr = nombre de bit (cellules) du registre � d�calage (nr_max=18) 
% Te = periode d'�chantillonnage
% p = diviseur de fr�quence (d'�chantillonnage)
% a = niveau (la SBPA varie entre -a et +a)  
% n = nombre de p�riodes de la SBPA
%
% La longueur r�sultante est L'=n*p*L o� L = 2^nr-1
%

% table des bits additionnes
T = cell(10,1);
T{1} = [];
T{2} = 3-[1, 2];
T{3} = 4-[1, 3];
%T{4} = 5-[3, 4];
T{4} = 5-[1,4];
%T{5} = 6-[3, 5];
T{5} = 6-[2,5];
%T{6} = 7-[5, 6];
T{6} = 7-[1,6];
%T{7} = 8-[4, 7];
T{7} = 8-[1,7];
%T{8} = 9-[2, 3 , 4 , 8];
T{8} = 9-[1,2,7,8];
%T{9} = 10-[5, 9];
T{9} = 10-[4,9];
%T{10} = 11-[7, 10];
T{10} = 11-[3,10];
T{11} = 12-[9,11];
T{12} = 13-[6,8,11,12];
T{13} = 14-[9,10,12,13];
T{14} = 15-[4,8,13,14];
T{15} = 16-[14,15];
T{16} = 17-[4,13,15,16];
T{17} = 18-[14,17];
T{18} = 19-[11,18];

u=[];
registre=2^nr-1;

reg_evolution=[];
for i=1:(2^nr-1)
	    
   reg_vect=[];
   for j=1:nr
      reg_vect=[bitget(registre,j) reg_vect];
   end
   
   reg_evolution=[reg_evolution; reg_vect];
   for i=1:p
      u=[u; (2*bitget(registre,1)-1)*a];
	end  
   xored_bit=xor(bitget(registre,T{nr}(1)),bitget(registre,T{nr}(2)));
   for k=1:length(T{nr})-2
   	xored_bit=xor(xored_bit,bitget(registre,T{nr}(2+k)));
   end		   
   %registre=bitshift(registre,-1,nr);
   registre=bitshift(registre,-1,'uint8');
   registre=bitset(registre,nr,xored_bit);
end

un=[];
for l=1:n
   un=[un; u];
end;

%reg_evolution;

y=un;
time=(0:Te:(length(un)-1)*Te)';
