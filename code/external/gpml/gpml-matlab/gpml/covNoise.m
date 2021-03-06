function [A, B] = covNoise(logtheta, x, z)
% MIN_NOISE = 1e-8; % 1e-4; 
global MIN_NOISE;
if (isempty(MIN_NOISE))
  %ME =  MException('CovNoise:UndefinedMinNoise', ...
  %		   'Need to define global variable MIN_NOISE');
  %throw(ME);
  MIN_NOISE = 1e-7;
end

% Independent covariance function, ie "white noise", with specified variance.
% The covariance function is specified as:
%
% k(x^p,x^q) = s2 * \delta(p,q)
%
% where s2 is the noise variance and \delta(p,q) is a Kronecker delta function
% which is 1 iff p=q and zero otherwise. The hyperparameter is
%
% logtheta = [ log(sqrt(s2)) ]
%
% For more help on design of covariance functions, try "help covFunctions".
%
% (C) Copyright 2006 by Carl Edward Rasmussen, 2006-03-24.
if nargin == 0, A = '1'; return; end              % report number of parameters

s2 = exp(2*logtheta);                                          % noise variance

if nargin == 2                                      % compute covariance matrix
  D = eye(size(x,1));
 
  A = (s2 + MIN_NOISE)*D;
elseif nargout == 2                              % compute test set covariances
  A = s2 + MIN_NOISE;
  B = 0;                               % zeros cross covariance by independence
else        
   D = eye(size(x,1));
  
  A = 2*s2*D;                          % compute derivative matrix
end

