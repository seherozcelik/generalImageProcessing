function [J,grayImRef] = adjustIntensity(imName,refName)

    grayIm = register(imName);

    grayImRef = register(refName);

    J = imhistmatch(grayIm,grayImRef);

end