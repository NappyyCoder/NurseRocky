"use client";

import { useState } from "react";

export function PolicyDocumentImage({
  src,
  alt,
}: {
  src: string;
  alt: string;
}) {
  const [visible, setVisible] = useState(true);

  if (!visible) return null;

  return (
    <figure className="policy-doc-figure">
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img
        src={src}
        alt={alt}
        className="policy-doc-image"
        onError={() => setVisible(false)}
      />
    </figure>
  );
}
