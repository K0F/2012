
float CylTest_CapsFirst( PVector pt1, PVector pt2, float lengthsq, float radius_sq, PVector testpt )
{
  float dx, dy, dz;	// vector d  from line segment point 1 to point 2
  float pdx, pdy, pdz;	// vector pd from point 1 to test point
  float dot, dsq;

  dx = pt2.x - pt1.x;	// translate so pt1 is origin.  Make vector from
  dy = pt2.y - pt1.y;     // pt1 to pt2.  Need for this is easily eliminated
  dz = pt2.z - pt1.z;

  pdx = testpt.x - pt1.x;		// vector from pt1 to test point.
  pdy = testpt.y - pt1.y;
  pdz = testpt.z - pt1.z;

  // Dot the d and pd vectors to see if point lies behind the 
  // cylinder cap at pt1.x, pt1.y, pt1.z

    dot = pdx * dx + pdy * dy + pdz * dz;

  // If dot is less than zero the point is behind the pt1 cap.
  // If greater than the cylinder axis line segment length squared
  // then the point is outside the other end cap at pt2.

  if ( dot < 0.0f || dot > lengthsq )
  {
    return( -1.0f );
  }
  else 
  {
    // Point lies within the parallel caps, so find
    // distance squared from point to line, using the fact that sin^2 + cos^2 = 1
    // the dot = cos() * |d||pd|, and cross*cross = sin^2 * |d|^2 * |pd|^2
    // Carefull: '*' means mult for scalars and dotproduct for vectors
    // In short, where dist is pt distance to cyl axis: 
    // dist = sin( pd to d ) * |pd|
    // distsq = dsq = (1 - cos^2( pd to d)) * |pd|^2
    // dsq = ( 1 - (pd * d)^2 / (|pd|^2 * |d|^2) ) * |pd|^2
    // dsq = pd * pd - dot * dot / lengthsq
    //  where lengthsq is d*d or |d|^2 that is passed into this function 

    // distance squared to the cylinder axis:

    dsq = (pdx*pdx + pdy*pdy + pdz*pdz) - dot*dot/lengthsq;

    if ( dsq > radius_sq )
    {
      return( -1.0f );
    }
    else
    {
      return( dsq );		// return distance squared to axis
    }
  }
}

